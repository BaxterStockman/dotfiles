#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Environmental variables
export DOTFILES_ROOT=$HOME/.dotfiles
export CONFIG_PATH=$DOTFILES_ROOT/source
export PATH=$HOME/bin:$DOTFILES_ROOT/bin:$PATH

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
    exists $2 && alias $1="$2"
}

src_all $CONFIG_PATH
