# Check that we're on Arch
[[ "$(cat /etc/issue 2> /dev/null)" =~ Arch ]] || return 1

# Other aliases
alias cower='cower --color=auto'
alias packauto='packer -Syu --noedit --noconfirm'
alias packquery='pacman -Q |grep'

# Odds and ends
if [[ `pgrep rxvt | wc -l` == 1 ]] && exists archey3; then
    archey3
fi
