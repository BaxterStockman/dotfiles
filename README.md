dotfiles
========

A Bash script for managing your GitHub-hosted configuration files.

About this project
------------------

This project was forked from Ben Alman's
[dotfiles](https://github.com/cowboy/dotfiles) but has since diverged
significantly.  In particular, it is designed to be more modular than its
progenitor by following a design approach similar to that of SysV-style
initscripts or Arch Linux's `PKGBUILD`s: `dotfiles` reads variables and
functions from files defined by the user, permitting more or less arbitrary
customizations.  The conventions that these sourced files must follow is
described below in the [Usage](#Usage) section.

Requirements
------------

`dotfiles` needs a relatively recent version of Bash -- something that supports
associative arrays and regular expressions.  It also require `git`, but you
probably knew that already :).  Also `coreutils`, or at least an `md5sum`
utility that presents the same interface as the version in `coreutils`.

Usage
-----

#### Environment

`dotfiles` respects the following environment variables, which are also passed
through to sourced scripts:

- `DOTFILES_ROOT`: the path where `dotfiles` will look for configuration files
  and instructions.  By default, `~/.dotfiles`.
- `DOTFILES_CONFIG_REPO`: the git repository hosting your configuration files.
  By default, this repository.
- `DOTFILES_RUNDIR`: where `dotfiles` will search for scripts to source.  By
  default, `$DOTFILES_ROOT/run`.
- `DOTFILES_DESTDIR`: the root of the tree where `dotfiles` will place your
  configuration files.  By default, `$HOME`.
- `DOTFILES_BACKUPDIR`: where `dotfiles` should store backups.  By default,
  `$DOTFILES_ROOT/backup`.
- `DOTFILES_CACHEDIR`: used for... I dunno.  May go away.  By default,
  `$DOTFILES_ROOT/caches`
- `DOTFILES_SKIP_INIT`: whether to skip downloading/upding
  `DOTFILES_CONFIG_REPO`.  False by default.
- `DOTFILES_NOCLOBBER`: whether `dotfiles` should preserve or clobber existing
  configuration files.  True by default.
- `DOTFILES_VERBOSE`: Doesn't actually do anything right now :).
- `DOTFILES_NOCLOBBER_EXT`: If `DOTFILES_NOCLOBBER` is true, this value will be
  appended to any files that shouldn't be clobbered.  `.custom` by default.
- `DOTFILES_NOCLOBBER_RCS`: An associative array whose keys represent file
  paths and whose values are whether or not those files can clobbered.
- `DOTFILES_INCLUDES`: An array containing regular expressions against which
  the processed directories are tested.  Only matching directories will be
  processed.
- `DOTFILES_EXCLUDES`: Like `DOTFILES_INCLUDES`, but only _non_-matching
  directories are processed.
- `DOTFILES_ENV`: A colon-separated string specifying paths to configuration
  files conforming to the format [described below](#Configuration file).  Files
  are loaded in the reverse of the order provided, so that the sooner a file
  appears the higher the precedence of the settings it contains.
- `DOTFILES_USE_COLOR`: Whether to print colorized output.  True by default.

`dotfiles` runs with several other variables which can't be set from the
controlling terminal:
- `DOTFILES_VERSION`: a version string.
- `DOTFILES_PATH`: whatever is in `${BASH_SOURCE[0]}`.
- `DOTFILES_DIRNAME`: `$SCRIPT_PATH` minus the last forward slash and
  everything that follows it.
- `DOTFILES_BASENAME`: `$SCRIPT_PATH` minus the last forward slash and
  everything preceding it.

#### Configuration file

`dotfiles` reads configuration files at the following locations, in addition to
whatever is given in `DOTFILES_ENV`:
- `/etc/dotfiles.conf`
- `$XDG_CONFIG_HOME/dotfiles/dotfiles.conf` (If `XDG_CONFIG_HOME` is unset,
  `dotfiles` will instead check `$HOME/.config/dotfiles/dotfiles.conf`)
- `$HOME/.dotfilesrc`

Configuration files follow an INI-style format.  Global-scope options (_i.e._
options that don't appear under a `[heading]`) are prefixed with `DOTFILES_`;
options that appear under sections are prefixed with `DOTFILES_[UPPERCASED
SECTION NAME]_`.  `dotfiles` itself does not use any of these variables, but
you might find them useful to 'namespace' variables used by your sourced
scripts.  Variables appearing under the special section `[env]` will be
uppercased but not prepended by anything.

A sample configuration file:

```
root=/path/to/dotfiles/root
use_color=no

[private]
eyes='are watching you'

[env]
home=/my/home/directory
lc_all=en_US.UTF-8
```

This will result in the following environment:

```
DOTFILES_ROOT=/path/to/dotfiles/root
DOTFILES_USE_COLOR=no
DOTFILES_PRIVATE_EYES='are watching you'
HOME=/my/home/directory
LC_ALL=en_US.UTF-8
```

#### Positional Parameters

- `dotfiles` passes through all command line options after a
  literal `--` to sourced scripts.  If you'd like to handle command line
  options, they'll come through in good old `$@`.  *Caveat* at present, there
  is no way to specify which sourced scripts receive which options -- they all
  get the full contents of `$@` after the first instance of `--`.

#### A note on truthiness

`dotfiles` treats the values '1', 'yes', true', 'on', and 'enable' as
indicating truth.  All other values are treated as indicating falsity.

### Conventions

Scripts sourced by `dotfiles` should conform to the following conventions:

#### Variables

- `header`: `dotfiles` will print this message as a preamble to executing the
  functions defined in the sourced file.  `dotfiles` prints a generic message
  if this variable is unset.
- `creates_files`: a truthy value.  This should be set to `0` or `false` if the
  script doesn't copy/link/etc. any files into `DOTFILES_DESTDIR`.  True by
  default.
- `processdir`: where `dotfiles` should look for files to process.  If it is a
  relative path, it is assumed to be relative to `DOTFILES_ROOT`.  If this
  variable is unset, `dotfiles` tries to infer which directory to process based
  on the name of the sourced file.  Whatever is left over after removing
  anything of the form [0-9]\*\_ from the beginning of the file and removing
  '.sh' from the end is treated as a path relative to `DOTFILES_ROOT`.  So, for
  instance, `20_something.sh` would be converted to
  `$DOTFILES_ROOT/something`.

#### Functions

- `pre`: This is called once per sourced file prior to loop in which the `run`
  function, described below, is called.  This can be used as a hook for setup
  tasks.
- `run`: This is where the bulk of the work is done.  `run` is called once for
  each file located in `processdir`.  It receives two arguments: `$1` contains
  a source file somewhere in `processdir`, and `$2` contains the (putative)
  destination file -- i.e., somewhere in `DOTFILES_DESTDIR`.  This function is
  mandatory, and `dotfiles` will silently ignore any sourced file that doesn't
  contain it.
- `check`: this function is passed the same arguments as `run`.  If `run`
  should not be executed for a given input set, `check` should output a string
  (preferably containing the reason why these inputs should be skipped, since
  `dotfiles` is going to print the echoed message).  `check` should also
  indicate with the return code whether the reason for skipping was exceptional
  (return code `1`) or not (return code `2` -- I use this mostly for
  indicating the the destination file is the same as the source file).  `check`
  should return `0` for files that should not be skipped.  This function is
  optional.
- `post`: Like `pre`, but later.

