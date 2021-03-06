# Changelog

## [0.0.2] - 2015-11-29
### Added
- Library functions implementing common use cases: symlinking, copying,
  `skel`-style copying, arbitrary initialization, and optional forms of each of
  the foregoing.
- Improved configuration file parsing -- arrays and quoted values are now
  supported.

## [0.0.1] - 2015-11-16
### Added
- This very changelog
## Changed
- `dotfiles` can no longer be sourced.  It just pollutes the shell environment
  too much, and at the moment there's no apparent use case for it anyway.
- Added logic to search for configuration files in multiple paths, with the
  colon-separated `DOTFILES_ENV` environment variables optionally specifying
  extra paths in LIFO order.
- Factored out CLI options processing into a separate subroutine
- Added `gettext` support
- Updated logging functions to use more eye-catching tokens and colors
- The `process` function now runs in a subshell so that changes made within
  sourced files aren't propagated to other sourced files or to `dotfiles`
  itself.
- Added `installs_files` variable that, when not `truthy`, bypasses:
-- Verification that the directory under `DOTFILES_ROOT` corresponding to a
   given file under `DOTFILES_RUNDIR` exists
-- The loop that iterates over files in the mentioned source directory (since
   there presumably aren't any such files :)
- Removed vestigial variables like `DOTFILES_CACHEDIR`
- Updated (README)[README.md] to reflect changes to variables; also added
  description of the configuration file.
