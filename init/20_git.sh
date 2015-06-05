#!/usr/bin/env bash

function is_git_repo () {
    local moduledir="${1:-$DOTFILES_ROOT}"
    [[ -d "${moduledir}/.git" ]] || git rev-parse --git-dir &>/dev/null
}

e_header "Installing git submodules"

moduledir="$DOTFILES_ROOT"

if ! pushd "$moduledir" &>/dev/null; then
	e_error "Can't chdir to ${moduledir}; exiting" 1>&2
	return 1
fi

gitmodules_file="${moduledir}/.gitmodules"

if ! is_git_repo "$moduledir"; then
    e_error "${moduledir} is not a git repository" 1>&2
    exit 1
fi

if ! [[ -f "$gitmodules_file" ]]; then
    echo "${gitmodules_file} does not exist" 1>&2
    exit 1
fi

while read path_key path; do
    url_key="${path_key//\.path/.url}"
    url="$(git config -f "${gitmodules_file}" --get "${url_key}")"
    git submodule add -f "${url}" "${path}"
done < <(git config -f "${gitmodules_file}" --get-regexp '^submodule\..*\.path$')
