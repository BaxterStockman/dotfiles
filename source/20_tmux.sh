#!/usr/bin/env bash
# Bashrc SSH-tmux wrapper | Spencer Tipping
# Licensed under the terms of the MIT source code license

# Source this just after the PS1-check to enable auto-tmuxing of your SSH
# sessions. See https://github.com/spencertipping/bashrc-tmux for usage
# information.

T3=$(pgrep -u $USER -x irssi)
logfile="$HOME/.log/bash_tmux.log"
prefix=""
irc_win="irssi"

log() {
    local log_dest=$1
    shift
    local prefix="[$(date +%Y/%m/%d\ %H:%M:%S)]: "
    echo "${prefix} $@" >> $log_dest
}

irssi_nickpane() {
    [[ -n $2 ]] && end_target=$2 || end_target=$1
    log $logfile "end target is window $end_target"
    tmux selectw -t $1
    tmux setw main-pane-width $(( $(tput cols) - 21));
    tmux splitw -v "cat ~/.irssi/nicklistfifo";
    tmux selectl main-vertical;
    if [[ "$end_target" == "$1" ]]; then
        tmux selectw -t $end_target;
        tmux selectp -t 0;
    else
        tmux selectw -t $end_target
    fi
}

irssi_repair() {
    currentw="$(tmux display-message -p '#W')"
    log $logfile "will return to $currentw after repairing irssi"
    (( $(tmux lsp -t $1 | wc -l) > 1 )) && tmux killp -a -t 0
    irssi_nickpane $1 $currentw
}

if [[ -z "$TMUX" ]] && exists tmux &> /dev/null; then
    export TERM="screen-256color"
    if [[ -n "$SSH_CONNECTION" ]]; then
        prefix="ssh"
    else
        prefix="local"
    fi

    base_session="$prefix-$USER"

    # Start base session if not already started.
    if ! tmux ls -F '#{session_name}' 2>/dev/null | grep "^$base_session$" > /dev/null; then
        tmux new-session -s $base_session \; detach
    fi

    # If irssi is installed and not already running under
    # the current user's uid, create a new window with the
    # value of $irc_win as its name and execute irssi
    if [[ -z "$T3" ]] && exists irssi &> /dev/null; then
        tmux new-window -t $base_session -n $irc_win irssi;
        irssi_nickpane $irc_win ;
    fi

  # Allocating a session ID.
  # There are two possibilities here. First, we could have a list of session
  # IDs that is densely packed; e.g. [0, 1, 2, 3, 4]. In this case, we want to
  # allocate 5.
  #
  # If, on the other hand, there is a gap, then it becomes unsafe to just use
  # #sessions as the new ID. So instead, we search through the list to see if
  # the difference between any pair is greater than one. (e.g. for [0, 1, 3, 5]
  # we would use 2)

    sessions=($(tmux ls -F '#{session_name}-#{session_attached}' \
                | egrep "^$base_session-[0-9]+.+?[01]$" \
                | sed "s/^$base_session-//" \
                | sort -n))
    session_index=${#sessions[@]}

    unattached=$session_index
    for ((i=0; i < ${#sessions[@]}; ++i)); do
        session_num=($(echo ${sessions[$i]} | sed "s/-[01]\+$//"))
        attached=($(echo ${sessions[$i]} | sed "s/^[0-9]\+-//"))
        if [[ $session_num -ne $i ]]; then
            tmux rename -t $base_session-$session_num $base_session-$i
            ${sessions[$i]}="$i $attached"
        fi
        if [[ $attached -eq 0 && $session_num < $unattached ]]; then
            unattached=$i
        fi
    done

    if [[ -n "$SSH_CONNECTION" ]]; then
        [[ $unattached < $session_index ]] && exec tmux attach -t $base_session-$unattached ||  \
            exec tmux new-session -s $base_session-$session_index -t $base_session
    else
        [[ $unattached < $session_index ]] && exec tmux attach -t $base_session-$unattached ||  \
            exec tmux new-session -s $base_session-$session_index
    fi

    if [[ -n "$T3" ]]; then
        irssi_repair $irc_win  ;
    fi

fi
