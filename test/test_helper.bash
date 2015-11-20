#!/usr/bin/env bash

declare -gx BATS_LOGFILE
BATS_LOGFILE="${BATS_DIRNAME:-${PWD}}/bats-$(date +%s).log"

declare -gx DOTFILES_REPO_ROOT=''
DOTFILES_REPO_ROOT="$(git rev-parse --show-toplevel)"
: "${DOTFILES_REPO_ROOT:=${BATS_TEST_DIRNAME}/..}"

setup () {
    export PATH="${DOTFILES_REPO_ROOT}:${PATH}"

    declare -gx DOTFILES_CONFIG_PATH="${BATS_TMPDIR}/dotfiles.conf"
    declare -gx DOTFILES_ENV="$DOTFILES_CONFIG_PATH"
    write_config

    # shellcheck disable=SC1090
    DOTFILES_AUTOMATED_TESTING=1 source "${DOTFILES_REPO_ROOT}/dotfiles"
}

bats_log () {
    printf '[%s (%i)]: %s\n' "$BATS_TEST_NAME" "$BATS_TEST_NUMBER" "$*" >> "$BATS_LOGFILE"
}

teardown () {
    rm -f "$DOTFILES_CONFIG_PATH"
}

write_config () {
    [[ -s "$DOTFILES_CONFIG_PATH" ]] || cat << EOF > "$DOTFILES_CONFIG_PATH"
googoo=gaga
[env]
this=that
[private]
eyes='are watching you'
EOF
}
