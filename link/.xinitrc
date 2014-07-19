#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# Check whether a program exists
function exists() {
    command -v $1 >/dev/null 2>&1 || test -e $1
}

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.xinitrc.local ]] && source ~/.xinitrc.local

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xresources.local ]] && xrdb -merge ~/.Xresources.local
exists urxvtd && urxvtd -q -o -f &

if [[ -n "$1" ]]; then
    exec $1
else
    exec ratpoison
fi
