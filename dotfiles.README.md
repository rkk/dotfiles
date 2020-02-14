# Dotfiles

Unix-style configuration files for a terminal-centric working
environment,

  - [i3 tiling window manager](https://i3wm.org/) and Sakura terminal emulator, using [Porter](https://github.com/rkk/porter) colors
  - Vim and Visual Studio Code editors with code navigation features and Git integration, focused on [Go](https://golang.org/) development
  - Custom programming-optimized [keyboard layout](https://github.com/rkk/Dvorarkk)
  - Programming, Unix, and Devops-oriented feeds in the [Newsbeuter](https://newsbeuter.org/) terminal RSS client

## Platforms
The primary platforms are Debian Linux, but contents are
also tested on Mac OS X (10.10+), where applicable and feasible.

## Installation
Installing these dotfiles consists of checking out this repository
into your home directory and running the setup scripts to install
and set up the needed packages. The scripts are idempotent, so
running them multiple times will do no harm.

All configuration items have the default file names and locations,
so once the repository has been checked out, the configuration will
be activated the next time you log in.

When installing for the first time,

    # cd ~
    # git init
    # git remote add origin git@github.com:rkk/dotfiles.git
    # git fetch
    # git checkout -f master
    # ~/dotfiles.install.sh
    # ~/.vim/install.sh

Please note that this might conflict with existing files, which must be
resolved manually.

When updating the dotfiles,

    # cd ~
    # git pull origin master
    # ~/dotfiles.install.sh
    # ~/.vim/install.sh

The master branch is kept stable - any experimental changes are restricted
to feature or host-specific branches, named "feature/NAME" and
"host/NAME", respectively.

Many thanks to Drew DeVault and the blog post
["Managing my dotfiles as a Git Repository"](https://drewdevault.com/2019/12/30/dotfiles.html),
demonstrating this lean way of using Git to track dotfiles without needing dotfiles
management software.


## Bug reports
Bug reports and pull requests are highly appreciated.


## License
This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
