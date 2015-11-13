# First, make these into GitHub issues ;)
# Small stuff
## splitfile could just use `IFS=$'/' read ...`, rather than `local $IFS; read ...; unset $IFS`
## Cool fact: Bash allows '?' in function names, so we can do some Ruby-style
   stuff like renaming `is_true` to `true?` (or maybe `truthy?`)
# `process_check` is not DRY.  There should be a way to consolidate that
  `case`.
# Improve documentation
## Document all switches
## Document all environment variables
# Improve configuration file
## Options should not need to be prefixed with `dotfiles_`
## There should be a section
