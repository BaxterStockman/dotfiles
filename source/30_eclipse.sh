# Just a simple PATH alteration and some other environment stuff
if exists eclipse; then
    path_unshift /usr/share/eclipse
    export ECLIPSE_HOME=/usr/share/eclipse
fi
