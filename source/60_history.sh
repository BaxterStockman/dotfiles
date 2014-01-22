# History settings

# Allow use to re-edit a failed history substitution.
shopt -s histreedit
# History expansions will be verified before execution.
shopt -s histverify
# Enable history appending instead of overwriting.
shopt -s histappend

# History completion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000
# Assorted other stuff
export HISTIGNORE='history*'
export PROMPT_COMMAND="history -a"

# Easily re-execute the last history command.
alias r="fc -s"
