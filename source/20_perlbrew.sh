# Set up perlbrew env and source perlbrew's bashrc
export PERLBREW_ROOT=$HOME/opt/perl5/perlbrew

exists $PERLBREW_ROOT/bin/perlbrew || return 1
source ${PERLBREW_ROOT}/etc/bashrc  # Source bashrc located in perlbrew root directory
