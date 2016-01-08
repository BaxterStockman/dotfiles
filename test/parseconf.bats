#!/usr/bin/env bats

load test_helper

@test 'ensure that [_] (global) settings are as expected' {
    [[ "$DOTFILES_GOOGOO" == "gaga" ]]
}

@test 'ensure that [env] settings are as expected' {
    [[ "$THIS" == "that" ]]
}

@test 'ensure that [private] settings are as expected' {
    [[ "$DOTFILES_PRIVATE_EYES" == "are watching you" ]]
}

@test 'to_env_var() has expected output given different values for $header' {
    run to_env_var bin ary
    [[ "$output" == 'DOTFILES_BIN=ary' ]] || return $?

    run to_env_var bin ary env
    [[ "$output" == 'BIN=ary' ]] || return $?

    run to_env_var bin ary blob
    [[ "$output" == 'DOTFILES_BLOB_BIN=ary' ]] || return $?
}


