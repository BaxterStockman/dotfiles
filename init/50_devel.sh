# Update the spf13-vim distribution of
# Vim configuration files and plugins
update_spf13-vim() {
    spf13dir="$HOME/.spf13-vim-3"
    [[ -e $spf13dir ]] || return 1
    cd $spf13dir
    [[ $(git pull) =~ "up-to-date" ]] && return 1
    vim +BundleInstall! +BundleClean +q +q
    ch $HOME
    return 0
}

# If Vim exists, try to update spf13-vim.
# Otherwise, install spf13-vim
exists vim && update_spf13-vim || exec curl -L http://j.mp/spf13-vim3 | sh

if ! exists perlbrew; then
  cat <<EOF
Would you like to install Perlbrew?

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
  read -N 1 -t 15 -p "Install Perlbrew? [y/N] " install_perlbrew; echo
  if [[ "$install_perlbrew" =~ [Yy] ]]; then
    e_header "Installing Perlbrew"
    export PERLBREW_ROOT=$HOME/opt/perl5/perlbrew
    curl -L http://install.perlbrew.pl | bash >/dev/null 2>&1 &&
    echo "Installed Perlbrew." ||
    echo "Error installing Perlbrew."
  else
    echo "Skipping."
  fi
fi

