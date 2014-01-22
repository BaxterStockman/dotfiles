# Dotfiles

Cloned from [Ben Alman's](https://github.com/cowboy/dotfiles) dotfiles repo.

I've made a few small changes to better fit my preferred distributions and environment.

* The [dotfiles][dotfiles] command no longer installs Nave, rbenv, or gems.
* The default editor is set to Vim, and the installer pulls in spf13-vim.
* The [init][init] files now include scripts for Arch Linux.

I'm also working on implementing recursion in the [dotfiles][dotfiles] script so that it's
possible to link and/or copy configuration files that don't exist directly in the $HOME directory.
For instance, my [dwb][dwb] configuration files live at $HOME/.config/dwb, so I want the ability
to create the whole .config/dwb directory structure -- and to do so without clobbering whatever
other files might live somewhere in that tree on a given machine.  Right now, the recursion only
sort of works, but I'm sprucing it up day by day.

[dotfiles]: bin/dotfiles
[bin]: https://github.com/cowboy/dotfiles/tree/master/bin
[init]: https://github.com/cowboy/dotfiles/tree/master/bin
[dwb]: https://portix.bitbucket.org/

To install, paste the following into your shell and execute:

```sh
bash -c "$(curl -fsSL https://raw.github.com/BaxterStockman/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## Original README:

My OS X / Ubuntu dotfiles.

## Why is this a git repo?

I've been using bash on-and-off for a long time (since Slackware Linux was distributed on 1.44MB floppy disks). In all that time, every time I've set up a new Linux or OS X machine, I've copied over my `.bashrc` file and my `~/bin` folder to each machine manually. And I've never done a very good job of actually maintaining these files. It's been a total mess.

I finally decided that I wanted to be able to execute a single command to "bootstrap" a new system to pull down all of my dotfiles and configs, as well as install all the tools I commonly use. In addition, I wanted to be able to re-execute that command at any time to synchronize anything that might have changed. Finally, I wanted to make it easy to re-integrate changes back in, so that other machines could be updated.

That command is [dotfiles][dotfiles], and this is my "dotfiles" Git repo.

[dotfiles]: bin/dotfiles
[bin]: https://github.com/cowboy/dotfiles/tree/master/bin

## What, exactly, does the "dotfiles" command do?

It's really not very complicated. When [dotfiles][dotfiles] is run, it does a few things:

1. Git is installed if necessary, via APT or Homebrew (which is installed if necessary).
2. This repo is cloned into the `~/.dotfiles` directory (or updated if it already exists).
2. Files in `init` are executed (in alphanumeric order, hence the "50_" names).
3. Files in `copy` are copied into `~/`.
4. Files in `link` are linked into `~/`.

Note:

* The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
* Files in `bin` are executable shell scripts (Eg. [~/.dotfiles/bin][bin] is added into the path).
* Files in `source` get sourced whenever a new shell is opened (in alphanumeric order, hence the "50_" names).
* Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
* Files in `caches` are cached files, only used by some scripts. This folder will only be created if necessary.

## Installation
### OS X Notes

* You need to be an administrator (for `sudo`).
* You need to have installed [XCode](https://developer.apple.com/downloads/index.action?=xcode) or, at the very minimum, the [XCode Command Line Tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a _much smaller_ download thank XCode.

### Ubuntu Notes

* You need to be an administrator (for `sudo`).
* You might want to set up your ubuntu server [like I do it](/cowboy/dotfiles/wiki/ubuntu-setup), but then again, you might not.
* Either way, you should at least update/upgrade APT with `sudo apt-get -qq update && sudo apt-get -qq dist-upgrade` first.

### Actual Installation

```sh
bash -c "$(curl -fsSL https://bit.ly/cowboy-dotfiles)" && source ~/.bashrc
```

If, for some reason, [bit.ly](https://bit.ly/) is down, you can use the canonical URL.

```sh
bash -c "$(curl -fsSL https://raw.github.com/cowboy/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## The "init" step
A whole bunch of things will be installed, but _only_ if they aren't already.

### OS X
* Homebrew recipes
  * git
  * tree
  * sl
  * lesspipe
  * id3tool
  * nmap
  * git-extras
  * htop-osx
  * man2html
  * hub
  * cowsay
  * ssh-copy-id
  * apple-gcc42 (via [homebrew-dupes](https://github.com/Homebrew/homebrew-dupes/blob/master/apple-gcc42.rb))

### Ubuntu
* APT packages
  * build-essential
  * libssl-dev
  * git-core
  * tree
  * sl
  * id3tool
  * cowsay
  * nmap
  * telnet
  * htop

### Both
* Nave
  * node (latest stable)
    * npm
    * grunt-cli
    * linken
    * bower
    * node-inspector
    * yo
* rbenv
  * ruby 2.0.0-p247
* gems
  * bundler
  * awesome_print
  * pry
  * lolcat

## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Aliases and Functions
To keep things easy, the `~/.bashrc` and `~/.bash_profile` files are extremely simple, and should never need to be modified. Instead, add your aliases, functions, settings, etc into one of the files in the `source` subdirectory, or add a new file. They're all automatically sourced when a new shell is opened. Take a look, I have [a lot of aliases and functions](https://github.com/cowboy/dotfiles/tree/master/source). I even have a [fancy prompt](source/50_prompt.sh) that shows the current directory, time and current git/svn repo status.

## Scripts
In addition to the aforementioned [dotfiles][dotfiles] script, there are a few other [bash scripts][bin]. This includes [ack](https://github.com/petdance/ack), which is a [git submodule](https://github.com/cowboy/dotfiles/tree/master/libs).

* [dotfiles][dotfiles] - (re)initialize dotfiles. It might ask for your password (for `sudo`).
* [src](link/.bashrc#L6-15) - (re)source all files in `source` directory
* Look through the [bin][bin] subdirectory for a few more.

## Prompt
I think [my bash prompt](source/50_prompt.sh) is awesome. It shows git and svn repo status, a timestamp, error exit codes, and even changes color depending on how you've logged in.

Git repos display as **[branch:flags]** where flags are:

**?** untracked files
**!** changed (but unstaged) files
**+** staged files

SVN repos display as **[rev1:rev2]** where rev1 and rev2 are:

**rev1** last changed revision
**rev2** revision

Check it out:

![My awesome bash prompt](http://farm8.staticflickr.com/7142/6754488927_563dd73553_b.jpg)

## Inspiration
<https://github.com/gf3/dotfiles>
<https://github.com/mathiasbynens/dotfiles>
(and 15+ years of accumulated crap)

## License
Copyright (c) 2013 "Cowboy" Ben Alman
Licensed under the MIT license.
<http://benalman.com/about/license/>
