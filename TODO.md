* First, make these into GitHub issues ;)
* Small stuff
** `find_hierarchical` is ugly, and there's a potential infinite loop problem
   in the options processing logic.
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
* Document all functions
* Logging to file
* Don't try to read input if standard input is not a terminal
* Options processing is too simpleminded.  Take a look at `makepkg` for ideas.
* Fix exit code of main() to reflect new DOTFILES_EX_* codes
* The configuration file parser is incapable of handling associative arrays,
  which means that stuff like `$DOTFILES_NOCLOBBER_RCS` can't be set in the
  configuration file.
* `makepkg`-style logging functions
* Test whether compound [[ ... && ... ]] constructs are faster than the
  equivalent chained [[ ... ]] && [[ ... ]] versions
* Replace `find\_hierarchical`'s `--prefix` option by passing an absolute path
* Make the logging functions more like those in `makepkg` -- in particular, the
  first argument to the functions should be a format string.
* `parseconf` should handle array values
* dangling symlink issue
* Try to capture the output of failed commands
