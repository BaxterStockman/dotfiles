#!/usr/bin/env bats

load test_helper
load parseconf

@test 'ensure that [_] (global) settings are as expected' {
    bats_log "DOTFILES_GOOGOO=$DOTFILES_GOOGOO"
    [[ "$DOTFILES_GOOGOO" == "gaga" ]]
}

@test 'ensure that [env] settings are as expected' {
    bats_log "DOTFILES_THIS=$DOTFILES_THIS"
    [[ "$THIS" == "that" ]]
}

@test 'ensure that [private] settings are as expected' {
    bats_log "DOTFILES_PRIVATE_EYES=$DOTFILES_PRIVATE_EYES"
    [[ "$DOTFILES_PRIVATE_EYES" == "are watching you" ]]
}
