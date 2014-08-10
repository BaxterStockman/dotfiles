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
if exists vim; then
  cat <<EOF
Would you like to update spf13-vim?

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
  read -N 1 -t 15 -p "Update spf13-vim? [y/N] " update_spf13; echo
  if [[ "$update_spf13" =~ [Yy] ]]; then
    e_header "Updating spf13-vim"
    update_spf13-vim || exec curl -L http://j.mp/spf13-vim3 | sh &&
    echo "Updated spf13-vim." ||
    echo "Error updating spf13-vim."
  else
    echo "Skipping."
  fi
fi

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
    perlbrew install-patchperl
    perlbrew install-cpanm
  else
    echo "Skipping."
  fi
fi

if exists perlbrew && ! perlbrew list &>/dev/null; then
  cat <<EOF
Would you like to install the latest stable version of perl?

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
  read -N 1 -t 15 -p "Install perl? [y/N] " install_perl; echo
  if [[ "$install_perl" =~ [Yy] ]]; then
    e_header "Installing perl"
    export PERLBREW_ROOT=$HOME/opt/perl5/perlbrew
    perlbrew install stable &&
    echo "Installed perl." ||
    echo "Error installing perl."
    perlbrew switch `perlbrew list | grep -o "perl-.*"`
  else
    echo "Skipping."
  fi
fi

