# Stuff that doesn't work in OSX.
# Abort if OSX detected.
#
# More stuff is likely to end up in
# here as I discover it over time.
[[ "$OSTYPE" =~ ^darwin ]] && return 1

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
