# Check that we're on Arch
[[ "$(cat /etc/issue 2> /dev/null)" =~ Arch ]] || return 1

if [[ -z $($PKG_CHECK_INSTALLED "packer") ]]; then
  e_header "Installing Packer"
  PACKER_PKGBUILD_URL="https://aur.archlinux.org/packages/pa/packer/PKGBUILD"
  CWD=$(pwd)
  BUILD_DIR="./packer"
  cd $BUILD_DIR
  curl $PACKER_PKGBUILD_URL
  makepkg -s PKGBUILD
  PACKER_PKG=$(ls packer*pkg.tar.xz)
  sudo pacman -U $PACKER_PKG
fi

e_header "Updating packages"
packer -Syy

# Upgrade existing packages
cat <<EOF
Would you like to upgrade installed packages?

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
read -N 1 -t 15 -p "Upgrade packages? [y/N] " upgrade_packages; echo
    if [[ "$upgrade_packages" =~ [Yy] ]]; then
        e_header "Upgrading packages"
        packer -Su
        echo "Upgraded packages." ||
        echo "Error upgrading packages"
    else
        echo "Skipping."
fi

# Install new packages
pkgs=(
    bash-completion
    ranger
    ruby
    rxvt-unicode-terminfo
    tmux
    vim
    wget
    xbindkeys
)
