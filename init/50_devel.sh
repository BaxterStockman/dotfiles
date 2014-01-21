
update_spf13() {
    cd $HOME/.spf13-vim-3
    git pull
    vim +BundleInstall! +BundleClean +q
}

[ update_spf13 >/dev/null 2>&1 ] || curl http://j.mp/spf13-vim -L -o - | sh
