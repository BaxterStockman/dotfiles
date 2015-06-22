dotfiles
========

A pure Bash script for managing your configuration files.

About this project
------------------

This project was forked from Ben Alman's
[dotfiles](https://github.com/cowboy/dotfiles) but has since diverged
significantly.  In particular, it is designed to be more modular than its
progenitor by following a design approach similar to that of SysV-style
initscripts or Arch Linux's `PKGBUILD`s: `dotfiles` reads variables and
functions from files defined by the user, permitting more or less arbitrarily
customizations.  The conventions that these sourced files must follow is
described below in the Usage section.

Usage
-----

#### Environment

`dotfiles` respects the following environment variables, which are also passed
through to sourced scripts:

- `DOTFILES_BACKUP_PATH`: where `dotfiles` should store backups.
- `DOTFILES_CACHE_PATH`: used for... I dunno.
- `DOTFILES_DESTDIR`: the root of the tree where `dotfiles` will place your
  configuration files.
- `DOTFILES_BINDIR`: where the `dotfiles` script will be checked out from git.
- `DOTFILES_RUNDIR`: where `dotfiles` will search for scripts to source.
- `DOTFILES_NEW_INSTALL`: whether this is a new `dotfiles` installation.
- `DOTFILES_REPO`: the git repository hosting the `dotfiles` script.
- `DOTFILES_CONFIG_REPO`: the git repository hosting your configuration files.
- `DOTFILES_SKIP_INIT`: whether to skip certain installation steps.
- `DOTFILES_NOCLOBBER`: whether `dotfiles` should preserve or clobber existing
  configuration files.  True by default.
- `DOTFILES_VERBOSE`: Doesn't actually do anything right now :).
- `DOTFILES_NOCLOBBER_EXT`: If `DOTFILES_NOCLOBBER` is true, this value will be
  appended to any files that shouldn't be clobbered.
- `DOTFILES_NOCLOBBER_RCS`: A Bash array containing files that should not be
  clobbered.

Scripts sourced by `dotfiles` should conform to the following conventions:

#### Variables

- `header`: `dotfiles` will print this message as a preamble to executing the
  functions defined in the sourced file.  `dotfiles` prints a generic method if
  this variable is unset.
- `processdir`: where `dotfiles` should look for files to process.  If it is a
  relative path, it is assumed to be relative to `DOTFILES_ROOT`.  If this
  variable is unset, `dotfiles` tries to infer which directory to process based
  on the name of the sourced file.  Whatever is left over after removing
  anything of the form [0-9]\*\_ from the beginning of the file and removing
  '.sh' from the end is treated as a path relative to `DOTFILES_ROOT`.  So, for
  instance, `20_something.sh` would be converted to
  `$DOTFILES_ROOT/something`.

#### Functions

- `parseopts`: `dotfiles` passes through all command line options after a
  literal `--` to this function.  If you'd like to handle command line options,
  this is the place to do it -- they'll come through in good old `$@`.
- `run`: This is where the bulk of the work is done.  `run` receives two
  arguments: `$1` contains a source file somewhere in `processdir`, and `$2`
  contains the (putative) destination file -- i.e., somewhere in
  `DOTFILES_DESTDIR`.
- `check`: this function is passed the same arguments as `run`.  If `run`
  should not be executed for a given input set, `check` should ouput a string
  (preferably containing the reason why these inputs should be skipped, since
  `dotfiles` is going to print the echoed message).



