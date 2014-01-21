#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Environmental variables
export DOTFILES_ROOT=$HOME/.dotfiles
export CONFIG_PATH=$DOTFILES_ROOT/source
export PATH=$HOME/bin/:$PATH:$DOTFILES_ROOT/bin

# Source file if it exists
# First argument = directory
# Second argument = relative path of file
function src_file() {
    if [[ "$2" ]]; then
        source "$1/$2.sh"
    fi
}

# Source all files in a directory
function src_dir() {
    local file
    files=($(ls -A $1/ | sort))
    for file in ${files[@]}; do
        source "$1/$file"
    done
}

# Run dotfiles script, then source.
function dotfiles() {
    ~/.dotfiles/bin/dotfiles "$@" && src_dir $CONFIG_PATH
}

# Check whether a program exists and
exists() {
    command -v $1 >/dev/null 2>&1
}

# Check whether a program exists and
# if so alias it to the string passed
# as the second argument
alias_if() {
    exists $2 && alias $1="$2"
}

src_dir $CONFIG_PATH
