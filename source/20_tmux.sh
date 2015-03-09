#!/usr/bin/env bash
# Bashrc SSH-tmux wrapper | Spencer Tipping
# Licensed under the terms of the MIT source code license

# Source this just after the PS1-check to enable auto-tmuxing of your SSH
# sessions. See https://github.com/spencertipping/bashrc-tmux for usage
# information.

# Don't source this file if tmux isn't runnable
#exists tmux || return

# Don't start if we're root
[[ $EUID -eq 0 ]] && return

# Use a separate socket if we're running in a low-color environment
if [[ $TERM == linux ]]
then
    alias tmux='tmux -L getty'
    return
fi

COLOR_COUNT="${COLOR_COUNT:-$(tput colors)}"
if [[ $COLOR_COUNT -ge 256 ]]
then
    alias tmux='tmux -2'
fi

if [[ -z "$TMUX" ]] && exists tmux &> /dev/null
then
    if [[ -n "$SSH_CONNECTION" ]]
    then
        prefix="ssh"
    else
        prefix="local"
    fi

    base_session="$prefix-$USER"

    # Start base session if not already started.
    if ! tmux ls -F '#{session_name}' 2>/dev/null | grep "^$base_session$" > /dev/null
    then
        tmux new-session -s $base_session \; detach
    fi

    # Allocating a session ID. There are two possibilities here. First, we
    # could have a list of session IDs that is densely packed; e.g. [0, 1, 2,
    # 3, 4]. In this case, we want to allocate 6.
    #
    # If, on the other hand, there is a gap, then it becomes unsafe to just use
    # #sessions as the new ID. So instead, we search through the list to see if
    # the difference between any pair is greater than one. (e.g. for [0, 1, 3,
    # 5] we would use 2)

    sessions=($(tmux ls -F '#{session_name}-#{session_attached}' \
                | egrep "^$base_session-[0-9]+.+?[01]$" \
                | sed "s/^$base_session-//" \
                | sort -n))
    session_index=${#sessions[@]}

    unattached=$session_index
    for ((i=0; i < ${#sessions[@]}; ++i))
    do
        session_num=$(echo ${sessions[$i]} | sed "s/-[01]\+$//")
        attached=$(echo ${sessions[$i]} | sed "s/^[0-9]\+-//")
        if [[ $session_num -ne $i ]]
        then
            tmux rename -t $base_session-$session_num $base_session-$i
            ${sessions[$i]}="$i $attached"
        fi

        if [[ $attached -eq 0 ]] && [[ $session_num < $unattached ]]
        then
            unattached=$i
        fi
    done

    if [[ -n "$SSH_CONNECTION" ]]; then
        if [[ $unattached < $session_index ]]
        then
            exec tmux attach -t $base_session-$unattached
        else
            exec tmux new-session -s $base_session-$session_index -t $base_session
        fi
    else
        if [[ $unattached < $session_index ]]
        then
            exec tmux attach -t $base_session-$unattached
        else
            exec tmux new-session -s $base_session-$session_index
        fi
    fi

    if [[ -n "$T3" ]] && exists irssi &> /dev/null
    then
        irssi_repair $irc_win
    fi
fi
