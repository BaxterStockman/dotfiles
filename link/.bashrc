#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Environmental variables
export DOTFILES_ROOT=$HOME/.dotfiles
export CONFIG_PATH=$DOTFILES_ROOT/source
export PATH=$DOTFILES_ROOT/bin:$PATH
[ -e $HOME/bin ] && export PATH=$HOME/bin:$PATH

# Source file if it exists
# First argument = directory
# Second argument = relative path of file
function src_file() {
    if [[ "$2" ]]; then
        source "$1/$2.sh"
    fi
}

# Source all files in a directory
function src_all() {
    local file
    for file in $1/*; do
        source "$file"
    done
}

# Run dotfiles script, then source.
function dotfiles() {
    $DOTFILES_ROOT/bin/dotfiles "$@" && src_all $CONFIG_PATH
}

# Check whether a program exists and
exists() {
    command -v $1 >/dev/null 3>&1
}

# Check whether a program exists and
# if so alias it to the string passed
# as the second argument
alias_if() {
    OIFS="$IFS"
    IFS='=' read -a args <<< "$1"
    exists ${args[1]} && alias ${args[0]}="${args[1]}"
    echo "${args[0]} -> ${args[1]}" &>> ~/alias.txt
    IFS="$OIFS"
}

src_all $CONFIG_PATH
