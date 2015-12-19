#!/usr/bin/env bash

init () {
    DOTFILES_REPO_ROOT=''
    DOTFILES_REPO_ROOT="$(git rev-parse --show-toplevel)"
    : "${DOTFILES_REPO_ROOT:=${BATS_TEST_DIRNAME}/..}"

    export PATH="${DOTFILES_REPO_ROOT}:${PATH}"

    DOTFILES_CONFIG_PATH="${BATS_TEST_DIRNAME}/fixtures/etc/dotfiles.conf"
    DOTFILES_ENV="$DOTFILES_CONFIG_PATH"

    { set -- ; AUTOMATED_TESTING=1 source "${DOTFILES_REPO_ROOT}/dotfiles" ; }
}

init
