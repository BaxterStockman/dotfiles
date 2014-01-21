# Set tmux to automatically use 256 colors
alias_if tmux 'tmux -2'

# If it exists, source a script that automatically
# starts a tmux session
[[ -f ~/.bash_tmux ]] && source ~/.bash_tmux
