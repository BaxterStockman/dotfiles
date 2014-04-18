#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xresources.local ]] && xrdb -merge ~/.Xresources.local
[[ -f ~/.xinitrc.local ]] && source ~/.xinitrc.local
exists urxvtc && exec urxvtc

exec $1
