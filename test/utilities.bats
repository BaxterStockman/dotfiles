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

@test "md5cmp return success for identical files" {
    tmpfile="$(mktemp)"
    echo 'a dummy value' > "$tmpfile"
    run md5cmp "$tmpfile" "$tmpfile"
    rm "$tmpfile"
}

@test "md5cmp return failure for different files" {
    tmpfile1="$(mktemp)"
    tmpfile2="$(mktemp)"

    echo 'a dummy value' > "$tmpfile1"
    echo 'another dummy value' > "$tmpfile2"

    run md5cmp "$tmpfile1" "$tmpfile2"

    rm "$tmpfile1" "$tmpfile2"

    (( status != 0 ))
}
