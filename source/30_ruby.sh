#!/usr/bin/env bash

# Make local gems available
exists ruby && exists gem || return

declare -g GEM_HOME
GEM_HOME="$(ruby -rubygems -e 'print Gem.user_dir')"
export GEM_HOME
path_unshift "${GEM_HOME}/bin"
