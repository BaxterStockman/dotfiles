#!/usr/bin/env bash

install_vim_plug () {
    local vim_autoload_path="${1:-${HOME}/.vim/autoload}"

    if ! type -P curl; then
        e_error "Curl is not installed; aborting"
        return 1
    fi

    curl -fLo "${vim_autoload_path}/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plugmaster/plug.vim
}

update_vim_plug () {
    vim +PlugUpgrade +PlugUpdate +qall
}

# If Vim exists, try to update spf13-vim.
# Otherwise, install spf13-vim
if type -P vim >/dev/null; then
    e_header "Updating vim-plug"
    if ! update_vim_plug 2>/dev/null; then
        if ! install_vim_plug "$DOTFILES_VIM_AUTOLOAD_PATH"; then
            e_error "Failed to install vim-plug"
            return 1
        fi
        update_vim_plug 2>/dev/null
    fi
fi
