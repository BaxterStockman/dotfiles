#
# ~/.bashrc
#

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Environmental variables
export DOTFILES_ROOT=$HOME/.dotfiles
export CONFIG_PATH=$DOTFILES_ROOT/source
export PATH=$DOTFILES_ROOT/bin:$PATH
[[ -e $HOME/sbin ]] && export PATH=$HOME/sbin:$PATH
[[ -e $HOME/bin ]] && export PATH=$HOME/bin:$PATH
[[ -e $HOME/lib ]] && export LD_LIBRARY_PATH=$HOME/lib

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
    command -v $1 >/dev/null 2>&1
}

# Check whether a program exists and
# if so alias it to the string passed
# as the second argument
alias_if() {
    OIFS="$IFS"
    IFS='=' read -a args <<< "$1"
    exists ${args[1]} && alias ${args[0]}="${args[1]}"
    IFS="$OIFS"
}

src_all $CONFIG_PATH
