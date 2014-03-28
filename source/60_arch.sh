# Check that we're on Arch
[[ "$(cat /etc/issue 2> /dev/null)" =~ Arch ]] || return 1

# Other aliases
alias cower='cower --color=auto'
alias packauto='packer -Syu --noedit --noconfirm'
alias packquery='pacman -Q |grep'

## Privileged access
if [ $UID -ne 0 ]; then
    alias_if reboot='sudo systemctl reboot'
    alias_if poweroff='sudo systemctl poweroff'
    alias_if update='sudo pacman -Su'
    alias_if netctl='sudo netctl'
fi

# Odds and ends
if [[ `pgrep rxvt | wc -l` == 1 ]] && exists archey3; then
    archey3
fi
