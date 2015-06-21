#!/usr/bin/env bash

header="Linking files into ${DOTFILES_DESTDIR}"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
check () {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    local srcfile="$1"
    local destfile="$2"

    if [[ "${srcfile}" -ef "${destfile}" ]]; then
        echo "link already exists"
        return 0
    fi

    return 1
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
run () {
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    local srcfile="$1"
    local destfile="$2"
    local destdir="${destfile%/*}"

    if ! mkdir -p "$destdir" >/dev/null; then
        e_error "Can't link ${destfile} to ${srcfile}"
        return 1
    fi

    ln -sf "$srcfile" "$destfile"
    e_success "Linking ${srcfile} to ${destfile}"
}
