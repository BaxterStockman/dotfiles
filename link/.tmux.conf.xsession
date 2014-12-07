###############################################################################
# Keybindings
###############################################################################

bind y run 'tmux save-buffer - | xsel -i 2>/dev/null' ; display-message 'Copied text from tmux buffer to system clipboard'
bind -t vi-copy 'Y' copy-pipe 'xsel -i 2>/dev/null' ; display-message 'Copied text to system clipboard'

###############################################################################
# Cosmetics
###############################################################################

### Windows
# fiddle with colors of inactive windows
setw -g window-status-style fg=colour244,bg=default,dim

# change color of active window
setw -g window-status-current-style fg=colour166,bg=default,bright

### Panes
# set color of regular and active panes
set -g pane-border-style fg=colour235
set -g pane-active-border-style fg=colour240
set -g display-panes-active-colour colour33
set -g display-panes-colour colour166

### Clock
setw -g clock-mode-colour colour64

### Command line
# set color of command line
set -g message-style fg=colour166,bg=colour235

### Status bar
# fiddle with colors of status bar
set -g status-style fg=colour136,bg=colour235

# configure contents of status bar
set -g status-utf8 on
set -g status-interval 2
set -g status-left-length 24
set -g status-left "#[fg=colour136,dim]#S"
set -g status-right "#[fg=colour136,dim] #h | %d %b %R"
