#!/usr/bin/env bats

load test_helper
load logging

@test "logging functions write to stderr" {
    skip 'bats is weird'

    local consolidated_output=''

    # Close stderr
    exec 2>&-

    for log_f in title prompt msg msg2 warning error fatal; do
        run "$log_f" 'dummy output'
        consolidated_output+="$output"
    done

    [[ -z "$consolidated_output" ]]
}

@test "title() outputs expected format" {
    run title 'hello world'
    print_on_fail "$output" "*'::'*'hello world'*"
}

@test "prompt() outputs expected format" {
    run prompt 'hello world'
    print_on_fail "$output" "*'>'*'hello world'*"
}

@test "msg() outputs expected format" {
    run msg 'hello world'
    print_on_fail "$output" "*'==>'*'hello world'*"
}

@test "msg2() outputs expected format" {
    run msg2 'hello world'
    print_on_fail "$output" "*' ->'*'hello world'*"
}

@test "warning() outputs expected format" {
    run warning 'hello world'
    print_on_fail "$output" "*'==> WARNING'*'hello world'*"
}

@test "error() outputs expected format" {
    run error 'hello world'
    print_on_fail "$output" "*'==> ERROR'*'hello world'*"
}

@test "fatal() outputs expected format" {
    run fatal 'hello world'
    print_on_fail "$output" "*'==> FATAL'*'hello world'*"
}
