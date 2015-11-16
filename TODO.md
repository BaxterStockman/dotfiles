* First, make these into GitHub issues ;)
* Small stuff
** `splitfile` could just use `IFS=$'/' read ...`, rather than `local $IFS; read ...; unset $IFS`
** `find_hierarchical` is ugly, and there's a potential infinite loop problem
   in the options processing logic.
** Cool fact: Bash allows '?' in function names, so we can do some Ruby-style
   stuff like renaming `is_true` to `true?` (or maybe `truthy?`)
** Function declaration style fix: function () => function()
** Associative arrays for storing:
*** Options => Help messages
** Arrays for storing:
*** Files that were backed up
* `process_check` is not DRY.  There should be a way to consolidate that
  `case`.
* Improve documentation
** Document all switches
** Document all environment variables
* Improve configuration file
** Options should not need to be prefixed with `dotfiles_`
** There should be a section
* Remove OSTYPE stuff
* Document all functions
* Use a LIB search path rather than just one RC file
