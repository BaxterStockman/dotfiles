# Update the spf13-vim distribution of
# Vim configuration files and plugins
update_spf13-vim() {
    cd $HOME/.spf13-vim-3
    git pull
    vim +BundleInstall! +BundleClean +q
}

# If Vim exists, try to update spf13-vim.
# Otherwise, install spf13-vim
exists vim && update_spf13-vim || curl http://j.mp/spf13-vim -L -o - | sh
