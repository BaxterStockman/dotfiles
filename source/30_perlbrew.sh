# Set up perlbrew env and source perlbrew's bashrc
export PERLBREW_ROOT=$HOME/opt/perl5/perlbrew

exists ${PERLBREW_ROOT}/bin/perlbrew || exists /usr/bin/vendor_perl/perlbrew || return
[[ -d ${PERLBREW_ROOT} ]] && source ${PERLBREW_ROOT}/etc/bashrc
