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
  `$DOTFILES_ROOT/something`.j

#### Functions

- `parseopts`: `dotfiles` passes through all command line options after a
  literal `--` to this function.  If you'd like to handle command line options,
  this is the place to do it -- they'll come through in good old `$@`.
- `run`: This is where the bulk of the work is done.  `run` receives two
  arguments: `$1` contains a source file somewhere in `processdir`, and `$2`
  contains the (putative) destination file -- i.e., somewhere in
  `DOTFILES_DESTDIR`.
- `check`: a function that

Environment
-----------

`dotfiles` respects the following environment variables:


