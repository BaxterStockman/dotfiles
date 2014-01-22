# Update the spf13-vim distribution of
# Vim configuration files and plugins
update_spf13-vim() {
    spf13dir="$HOME/.spf13-vim-3"
    [[ -e $spf13dir ]] || return 1
    cd $spf13dir
    [[ $(git pull) =~ "up-to-date" ]] && return 1
    vim +BundleInstall! +BundleClean +q +q
    return 0
}

# If Vim exists, try to update spf13-vim.
# Otherwise, install spf13-vim
exists vim && curl http://j.mp/spf13-vim -L -o - | sh
