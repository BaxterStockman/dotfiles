#!/usr/bin/env bats

load test_helper

@test 'check_noclobber() appends extension when destination file exists' {
    DOTFILES_NOCLOBBER_RE+=('.*')
    DOTFILES_NOCLOBBER=1 DOTFILES_NOCLOBBER_EXT='custom' run check_noclobber /dev/fd/1

    local expected=''
    printf -v expected "will be appended with '.custom'"
    [[ "$output" == *"/dev/fd/1 matches preservation filter"*"$expected"* ]]
}

@test 'check_noclobber() echoes untouched filename when file does not exist' {
    DOTFILES_NOCLOBBER=1 run check_noclobber /tmp/not/a/real/path
    [[ "$output" == /tmp/not/a/real/path ]]
}
