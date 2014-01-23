# Check that we're on Arch
[[ "$(cat /etc/issue 2> /dev/null)" =~ Arch ]] || return 1

e_header "Updating Pacman"
sudo pacman -Syy

# Upgrade existing packages
cat <<EOF
Would you like to upgrade installed packages?

This will be skipped if "Y" isn't pressed within the next 15 seconds.
EOF
read -N 1 -t 15 -p "Upgrade packages? [y/N] " upgrade_packages; echo
    if [[ "$upgrade_packages" =~ [Yy] ]]; then
        e_header "Upgrading packages"
        sudo pacman -Su
        echo "Upgraded packages." ||
        echo "Error upgrading packages"
    else
        echo "Skipping."
fi

# Install new packages
packages=(
    bash-completion
    ranger
    ruby
    rxvt-unicode-terminfo
    tmux
    vim
    wget
    xbindkeys
)


