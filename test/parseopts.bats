#!/usr/bin/env bats

load test_helper
load parseopts

@test "can run parseopts" {
    can_run_parseopts
}

@test "parseopts correctly splits long and short options" {
    skip_conditional
    parseopts 'a|alligator' 'b|bat:' OPTV -- -a --alligator -b this --bat that
    [[ "${OPTV[*]}" == '-a --alligator -b this --bat that --' ]]
}

@test "parseopts ignores global IFS" {
    skip_conditional
    export IFS=$'^'
    parseopts 'a|alligator' 'b|bat:' OPTV -- -a --alligator -b this --bat that
    unset IFS
    [[ "${OPTV[*]}" == '-a --alligator -b this --bat that --' ]]
}

@test "parseopts exits cleanly with empty CLI arguments array" {
    skip_conditional
    run parseopts 'n|nothing' OPTV
    (( status == 0 ))
}

@test "parseopts fails on invalid options" {
    skip_conditional
    run parseopts 'r|real' OPTV -- --unreal
    (( status != 0 )) && [[ "$output" == *'is not valid'* ]]
}

@test "parseopts fails on missing arguments" {
    skip_conditional
    run parseopts 'w|wants:' OPTV -- --wants
    (( status != 0 )) && [[ "$output" == *'requires an argument'* ]]
}

@test "parseopts fails when not provided valid variable to hold parsed options" {
    skip_conditional
    run parseopts 'i|have' 'two words' -- --for --you
    (( status != 0 )) && [[ "$output" == *'not a valid identifier'* ]]
}

@test "parseopts correctly processes unambiguous partial long options" {
    skip_conditional
    parseopts 'elephant:' 'el-guapo:' OPTV -- --ele mentary \
        && [[ "${OPTV[*]}" == *'--elephant mentary'* ]]
}

@test "parseopts fails on ambiguous options" {
    skip_conditional
    run parseopts 'onerous' 'one-time-one-time' OPTV -- --one
    (( status != 0 )) && [[ "$output" == *'option'*'has multiple matches'* ]]
}

@test "parseopts correctly processes long options with equals signs" {
    skip_conditional
    parseopts 'bat:' 'elephant:' OPTV -- --bat=man --elephant=itis
    (( status == 0 )) && [[ "${OPTV[*]}" == *'--bat man'* ]] && [[ "${OPTV[*]}" == *'--elephant itis'* ]]
}

@test "parseopts respects options bundling" {
    skip_conditional
    parseopts 'g' 'r' 'o' 'u' 'p' OPTV -- '-group'
    [[ "${OPTV[*]}" == '-g -r -o -u -p'* ]]
}

@test "parseopts recognizes more than one short option per spec" {
    skip_conditional
    parseopts 'b|r|o' OPTV -- '-bro'
    [[ "${OPTV[*]}" == '-b -r -o'* ]]
}

@test "parseopts recognizes more than one long option per spec" {
    skip_conditional
    parseopts 'tweedly|dee:' OPTV -- --tweedly deedly --dee dum
    [[ "${OPTV[*]}" == '--tweedly deedly --dee dum'* ]]
}

@test "parseopts passes through positional parameters" {
    skip_conditional
    parseopts 'n' OPTV -- -n this
    [[ "${OPTV[*]}" == *"-- this" ]]
}

@test "parseopts does not require space between short flag and argument" {
    skip_conditional
    parseopts 'h:' 'r:' OPTV -- -race -horse
    [[ "${OPTV[*]}" == "-r ace -h orse"* ]]
}
