# From http://stackoverflow.com/questions/370047/#370255
path_remove () {
    local IFS=:
    # convert it to an array
    local path_elems=($PATH)
    unset IFS
    # perform any array operations to remove elements from the array
    for to_remove in "$@"; do
        path_elems=(${path_elems[@]%%"$to_remove"})
    done
    IFS=:
    # output the new array
    echo "${path_elems[*]}"
}

path_push () {
    local IFS=:
    echo "${PATH}${PATH:+:}$*"
}

path_unshift () {
    local IFS=:
    echo "$*${PATH:+:}${PATH}"
}

# Check whether a program exists
exists () {
    local cmd="$1"
    command -v "$cmd" &>/dev/null || type -a "$cmd" &>/dev/null
}
