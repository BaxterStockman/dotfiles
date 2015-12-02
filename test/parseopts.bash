#!/usr/bin/env bash

declare -agx TESTOPTS=(
    'a|alligator'
    'b|bat:'
    'crayfish'
    'd'
    'elephant:'
    'f:'
)

declare -agx TESTOPTS_AMBIGUITY=(
    'craycray'
)

declare -agx ARGV=(
    -a
    --alligator
    -b aneye
    --bat aneye
    --crayfish
    -d
    --elephant intheroom
    -f this
)

declare -agx ARGV_MISSING_ARGS=(
    -b
    --elephant
)

declare -agx ARGV_INVALID_ARGS=(
    --grouse
)

declare -agx ARGV_PARTIAL=(
    --ele mentary
)

declare -agx ARGV_AMBIGUITY=(
    --cray
)

declare -agx ARGV_EQUALS_SIGN=(
    --bat=man
    --elephant=itis
)

declare -agx ARGV_EQUALS_SIGN_SHORT=(
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
        declare -gix CAN_RUN_PARSEOPTS=1
    else
        declare -gix CAN_RUN_PARSEOPTS=0
    fi

    (( CAN_RUN_PARSEOPTS ))
}

skip_conditional () {
    can_run_parseopts || skip "parseopts not declared"
}
