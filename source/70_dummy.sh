# My shell prompt displays a frowny face
# when the last process exited with an error
# status.  Since some of the files in
# .dotfiles/source test for OS, I often get
# the frowny face when, e.g., spawning a new
# shell.  This dummy file silences the error.

# History completion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

return 0
