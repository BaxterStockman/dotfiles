# cd and ls in one
cl() {
    if [[ -d "$1" ]]; then
        cd "$1"
        ls
    else
        echo "bash: cl: '$1': Directory not found"
    fi
}

# calculator
calc() {
    echo "scale=3;$@" | bc -l
}

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

if [[ -n $TMUX ]]
then
    function export () {
        local argv=$@
        local -A noexport=(
            [TERM]=1
        )

        builtin export "$@"

        local var val
        for item in "$argv"
        do
            # Remove the longest substring between the beginning of a flag and a
            # space character.  This should remove all but the positional
            # parameters that the 'export' builtin was invoked with.
            item=${item##-* }
            var=${item%%=*}
            val=${item#*=}
            [[ ${noexport[$var]} -eq 1 ]] && return
            [[ "$val" == "$var" ]] && val=${!var}
            tmux setenv "$var" "$val"
        done
    }

    function unset () {
        local argv=$@
        builtin unset "$@"

        for item in "$argv"
        do
            # Remove the longest substring between the beginning of a flag and a
            # space character.  This should remove all but the positional
            # parameters that the 'unset' builtin was invoked with.
            item=${item##-* }
            tmux setenv -u "$item"
        done
    }
fi
