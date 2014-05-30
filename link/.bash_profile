#
# ~/.bash_profile
#

#[[ $(tty) =~ /dev/tty[1-6] ]] && fbterm
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
