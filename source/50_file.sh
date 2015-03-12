# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 022

# Fast directory switching
_Z_NO_PROMPT_COMMAND=1
_Z_DATA=~/.dotfiles/caches/.z
. ~/.dotfiles/vendor/z/z.sh
