# From http://stackoverflow.com/questions/370047/#370255
function path_remove() {
  IFS=:
  # convert it to an array
  t=($PATH)
  unset IFS
  # perform any array operations to remove elements from the array
  t=(${t[@]%%$1})
  IFS=:
  # output the new array
  echo "${t[*]}"
}

# Check whether a program exists
function exists() {
    command -v $1 >/dev/null 2>&1
}

# Echoes a string representing a directory
# specification minus the root directory.
#
# E.g., the relpath of 'foo/bar/baz'
# is 'bar/baz'
function relpath() {
    echo "${1#*/}"
}

# Echoes a string representing a directory
# specification minus the last directory/file.
#
# E.g., the pathname of 'foo/bar/baz'
# is 'foo/bar'
function pathname() {
    echo "${1%/*}"
}

# Echoes a string representing the root
# directory of a directory specification.
#
# E.g., the basedir of 'foo/bar/baz'
# is 'foo'
function basedir() {
    head="${1#*/}"
}
