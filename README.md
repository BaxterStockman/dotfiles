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

`dotfiles` respects the following environment variables:


