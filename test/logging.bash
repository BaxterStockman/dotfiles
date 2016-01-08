#!/usr/bin/env bash

print_on_fail () {
    local output="$1"
    shift
    local match="$1"

    # NOTE $match is unquoted on purpose -- glob expansion.
    # shellcheck disable=SC2053
    [[ "$output" == $match ]] || echo 1>&2 "$output"
}
