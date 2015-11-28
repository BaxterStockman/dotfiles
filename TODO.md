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
* Move some of the functions from my `dotfiles-config` repo here, prefixed with
  a descriptive 'namespace' -- e.g. `link::run`, `link::test`, etc.
* Don't try to read input if standard input is not a terminal
* Options processing is too simpleminded.  Take a look at `makepkg` for ideas.
* Fix exit code of main() to reflect new DOTFILES_EX_* codes
* The configuration file parser is incapable of handling associative arrays,
  which means that stuff like `$DOTFILES_NOCLOBBER_RCS` can't be set in the
  configuration file.
