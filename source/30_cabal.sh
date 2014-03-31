# Set up cabal env
CABAL_ROOT=$HOME/.cabal

exists ${CABAL_ROOT}/bin/cabal || exists /usr/bin/cabal || return
export CABAL_ROOT
PATH=${CABAL_ROOT}/bin:$PATH
export PATH
