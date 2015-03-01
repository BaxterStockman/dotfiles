# Make local gems available
if exists ruby && exists gem
then
    export GEM_HOME="$(ruby -rubygems -e 'print Gem.user_dir')"
    export PATH="${GEM_HOME}/bin":$PATH
fi
