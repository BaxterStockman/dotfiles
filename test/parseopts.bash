#!/usr/bin/env bash

TESTOPTS=(
    'a|alligator'
    'b|bat:'
    'crayfish'
    'd'
    'elephant:'
    'f:'
)

TESTOPTS_AMBIGUITY=(
    'craycray'
)

ARGV=(
    -a
    --alligator
    -b aneye
    --bat aneye
    --crayfish
    -d
    --elephant intheroom
    -f this
)

ARGV_MISSING_ARGS=(
    -b
    --elephant
)

ARGV_INVALID_ARGS=(
    --grouse
)

ARGV_PARTIAL=(
    --ele mentary
)

ARGV_AMBIGUITY=(
    --cray
)

ARGV_EQUALS_SIGN=(
    --bat=man
    --elephant=itis
)

ARGV_EQUALS_SIGN_SHORT=(
    -b=plus
)

hasopts () {
    local -A argv_map
    while (( $# )) && [[ $1 != '--' ]]; do
        argv_map["$1"]=1
        shift
    done
    shift

    for v in "$@"; do
        [[ "${argv_map[$v]:-0}" -ne 1 ]] && return 1
    done

    return 0
}

can_run_parseopts () {
    if declare -F -- parseopts &>/dev/null; then
        CAN_RUN_PARSEOPTS=1
    else
        CAN_RUN_PARSEOPTS=0
    fi

    (( CAN_RUN_PARSEOPTS ))
}

skip_conditional () {
    can_run_parseopts || skip "parseopts not declared"
}
