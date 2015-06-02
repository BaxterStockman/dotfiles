#!/usr/bin/env bash

echo "HOME: $HOME"
DOTFILES_VIM_AUTOLOAD_PATH="${DOTFILES_VIM_AUTOLOAD_PATH:-${HOME}/.vim/autoload}"
DOTFILES_VIM_PLUG_PATH="${DOTFILES_VIM_PLUG_PATH:-${DOTFILES_VIM_AUTOLOAD_PATH}/plug.vim}"
echo "DOTFILES_VIM_AUTOLOAD_PATH: $DOTFILES_VIM_AUTOLOAD_PATH"
echo "DOTFILES_VIM_PLUG_PATH: $DOTFILES_VIM_PLUG_PATH"

install_vim_plug () {
    local vim_autoload_path="${1:-${HOME}/.vim/autoload}"

    if ! type -P curl; then
        e_error "Curl is not installed; aborting"
        return 1
    fi

    echo $vim_autoload_path
    curl -fLo "${vim_autoload_path}/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

update_vim_plug () {
    vim +PlugUpgrade +PlugUpdate +qall
}

# Uninstall spf13
for spf_13_dir in "${HOME}/.spf13" "${HOME}/.spf13-vim-3"; do
    if [[ -d "$spf_13_dir" ]]; then
        if [[ -x "${spf_13_dir}/uninstall.sh" ]]; then
            "${spf_13_dir}/uninstall.sh"
        else
            unlink "${HOME}/.vim"
            rm -rf "$spf_13_dir"
        fi
    fi
done

# If Vim exists, try to update vim-plug.  Otherwise, install it.
if type -P vim >/dev/null; then
    e_header "Updating vim-plug"
    if ! [[ -e "$DOTFILES_VIM_PLUG_PATH" ]]; then
        if ! install_vim_plug "$DOTFILES_VIM_AUTOLOAD_PATH"; then
            e_error "Failed to install vim-plug"
            return 1
        fi
    fi
    update_vim_plug
fi
