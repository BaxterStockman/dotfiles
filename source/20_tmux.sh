#!/usr/bin/env bash
# Bashrc SSH-tmux wrapper | Spencer Tipping
# Licensed under the terms of the MIT source code license

# Source this just after the PS1-check to enable auto-tmuxing of your SSH
# sessions. See https://github.com/spencertipping/bashrc-tmux for usage
# information.

# Don't source this file if tmux isn't runnable
exists tmux || return

# Don't start if we're root
[[ "${EUID}" -eq 0 ]] && return

# Use a separate socket if we're running in a low-color environment
if [[ "${TERM}" == linux ]]; then
    alias tmux='tmux -L getty'
    return
fi

if [[ "$(tput colors)" -ge 256 ]]; then
    alias tmux='tmux -2'
fi

function compress_sessions () {
  local base_session="$1"

  # Allocating a session ID. There are two possibilities here. First, we could have a list of
  # session IDs that is densely packed; e.g. [0, 1, 2, 3, 4]. In this case, we want to allocate 5.
  #
  # If, on the other hand, there is a gap, then it becomes unsafe to just use #sessions as the new
  # ID. So instead, we search through the list to see if the difference between any pair is greater
  # than one. (e.g. for [0, 1, 3, 5] we would use 2)
  #
  # XXX This approach (ab)uses the fact that tmux list-session always prints session info sorted
  # ASCII-betically by session name.
  local -a session_stats
  local session_name session_index session_line session_attached create_index create_attached

  if [[ -z "${create_index}" ]]; then
    create_index="$((session_index+1))"
    create_attached=false
  fi

  printf '%s %s' "${create_index}" "${create_attached}"
}

if [[ -z "${TMUX}" ]] && exists tmux &> /dev/null; then
  if [[ -n "${SSH_CONNECTION}" ]]; then
    prefix="ssh"
  else
    prefix="local"
  fi

  base_session="${prefix}-${USER}"

  # Start base session if not already started.
  if ! tmux has -t "${base_session}"; then
    tmux new-session -s "${base_session}" \; detach
  fi

  declare -A session_index_attached
  while read -r -a session_stats; do
    session_name="${session_stats[0]}"
    [[ "${session_name}" == ${base_session} ]] && continue

    session_index="${session_name##"${base_session}-"}"
    session_index_attached["${session_index}"]="${session_stats[1]}"
  done < <(tmux ls -F '#{session_name} #{session_attached}')

  create_index=0
  while true; do
    if ! tmux has -t "${base_session}-${create_index}"; then
      break
    elif [[ "${session_index_attached["${create_index}"]}" -eq 0 ]]; then
      exec tmux attach -t "${base_session}-${create_index}"
    fi
    ((create_index++))
  done

  if [[ -n "${SSH_CONNECTION}" ]]; then
    exec tmux new-session -s "${base_session}-${create_index}" -t "${base_session}"
  else
    exec tmux new-session -s "${base_session}-${create_index}"
  fi
fi
