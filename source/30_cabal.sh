# Set up cabal env
export CABAL_ROOT=$HOME/.cabal

exists ${CABAL_ROOT}/bin/cabal || exists /usr/bin/cabal || return
export CABAL_ROOT=${CABAL_ROOT}
export PATH=${CABAL_ROOT}/bin:$PATH
