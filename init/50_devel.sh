# Update the spf13-vim distribution of
# Vim configuration files and plugins
update_spf13-vim() {
    spf13dir="$HOME/.spf13-vim-3"
    [[ -e $spf13dir ]] || return 1
    cd $spf13dir
    [[ $(git pull) =~ "up-to-date" ]] && return 1
    vim +BundleInstall! +BundleClean +q +q
    cd $HOME
    return 0
}

# If Vim exists, try to update spf13-vim.
# Otherwise, install spf13-vim
if exists vim; then
  cat <<EOF
Would you like to update spf13-vim?

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
  read -N 1 -t 15 -p "Update spf13-vim? [y/N] " update_spf13; echo
  if [[ "$update_spf13" =~ [Yy] ]]; then
    e_header "Updating spf13-vim"
    update_spf13-vim || curl http://j.mp/spf13-vim3 -L -o - | sh &&
    echo "Updated spf13-vim." ||
    echo "Error updating spf13-vim."
  else
    echo "Skipping."
  fi
fi
