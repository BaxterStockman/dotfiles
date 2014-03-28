# Set up perlbrew env and source perlbrew's bashrc
export CABAL_ROOT=$HOME/.cabal

exists ${CABAL_ROOT}/bin/cabal || exists /usr/bin/cabal || return 1
export PATH=${CABAL_ROOT}/bin:$PATH
