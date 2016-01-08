#!/usr/bin/env bats

load test_helper

@test "utility functions exist in current environment" {
    local -i failed=0

    for func in truthy can_run; do
        run declare -f -- "$func"
        (( status == 0 )) || (( failed += 1 ))
    done

    (( failed == 0 ))
}

@test "truthy() returns success for expected values" {
    local -i failed=0
    local -a failed_names=()

    for v in 1 true yes on enable; do
        run truthy $v
        if (( status != DOTFILES_EX_OK )); then
            ((failed+=1))
            failed_names+=("$v")
        fi
    done

    (( failed == 0 ))
}

@test "truthy() returns failure for expected values" {
    local -i failed=0
    local -a failed_names=()
    local -a falsies=(0 false no off disable)

    for v in "${falsies[@]}"; do
        run truthy $v
        if (( status != DOTFILES_EX_FAIL )); then
            ((failed+=1))
            failed_names+=("$v")
        fi
    done

    (( failed == 0 ))
}

@test "can_run() returns success for known-present executables" {
    run can_run bash
}

@test "can_run() returns failure for known-absent executables" {
    run can_run anexecutablethatiamprettysuredoesnotexist
    (( status != 0 ))
}

@test "cmp() returns success for identical files" {
    tmpfile="$(mktemp)"

    echo 'a dummy value' > "$tmpfile"

    run cmp "$tmpfile" "$tmpfile"

    rm "$tmpfile"

    (( status == 0 ))
}

@test "cmp() returns failure for different files" {
    tmpfile1="$(mktemp)"
    tmpfile2="$(mktemp)"

    echo 'a dummy value' > "$tmpfile1"
    echo 'another dummy value' > "$tmpfile2"

    run cmp "$tmpfile1" "$tmpfile2"

    rm "$tmpfile1" "$tmpfile2"

    (( status != 0 ))
}

@test "splitfile() splits file path on '/'" {
    run splitfile /a/path/for/use/in/testing

    (( status == 0 )) && [[ "$output" == a*path*for*use*in*testing ]]
}

@test "splitfile() trims optional path prefix" {
    run splitfile /a/path/for/use/in/testing /a/path

    (( status == 0 )) && [[ "$output" == for*use*in*testing ]]
}

@test "call_conditional() returns success for non-existent function" {
    run call_conditional a_function_i_am_confident_does_not_exist
    (( status == DOTFILES_EX_OK ))
}

@test "call_conditional() returns the return code of the called function" {
    foo () { return 3 ; }
    run call_conditional foo
    unset -f foo
    (( status == 3 ))
}

@test "call_conditional() passes through arguments to called function" {
    foo () { echo "$*" ; }

    run call_conditional foo -- bar baz quux

    unset -f foo

    (( status == 0 )) && [[ "$output" == 'bar baz quux' ]]
}

@test "call_libfunc() returns success for non-existent function" {
    run call_libfunc a_function_i_am_confident_does_not_exist
    (( status == DOTFILES_EX_OK ))
}

@test "call_libfunc() returns the return code of the called function" {
    foo () { return 3 ; }
    run call_libfunc foo
    unset -f foo
    (( status == 3 ))
}

@test "call_libfunc() passes through arguments to called function" {
    foo () { echo "$*" ; }

    run call_libfunc foo -- bar baz quux

    unset -f foo

    (( status == 0 )) && [[ "$output" == 'bar baz quux' ]]
}

@test "call_libfunc() calls library function when first function does not exist" {
    aah::foo () { echo "gesundheit" ; }

    run call_libfunc foo aah

    (( status == 0 )) && [[ "$output" == gesundheit ]]
}

@test "check_git_repo() returns success when URL config matches wanted URL" {
    run check_repo_url http://foobar.com <(printf -- '[remote "origin"]\nurl=http://foobar.com')

    (( status == 0 ))
}

@test "check_git_repo() returns failure when URL config does not match wanted URL" {
    run check_repo_url http://foobar.com <(printf -- '[remote "origin"]\nurl=http://bazquux.com')

    (( status == DOTFILES_EX_FAIL ))
}

@test "test_varname() returns success for valid variable names" {
    local varname=''
    for varname in this THIS this_that; do
        test_varname "$varname" || return 1
    done
}

@test "test_varname() returns failure for invalid variable names" {
    local varname=''
    for varname in '%this' 'this&' 'this that' 'this::that'; do
        test_varname "$varname" && return 1
    done

    return 0
}
