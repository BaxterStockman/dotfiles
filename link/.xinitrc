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

for f in ~/.Xresources*; do
    [[ -f f ]] && xrdb -merge f
done

[[ -f ~/.xinitrc.local ]] && source ~/.xinitrc.local

