#!/usr/bin/env bats

# Order important here!
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
