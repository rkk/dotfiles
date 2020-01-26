# Dotfiles

Unix-style configuration files for a terminal-centric working
environment,

  - [i3 tiling window manager](https://i3wm.org/) and Sakura terminal emulator using [Solarized Light](http://ethanschoonover.com/solarized)
  - Vim editor with code navigation features and Git integration, focused on [Golang](https://golang.org/) development
  - Custom programming-optimized [keyboard layout](https://github.com/rkk/Dvorarkk)
  - Programming and Unix-oriented feeds in [Newsbeuter](https://newsbeuter.org/) terminal RSS client

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

In other words,

    $ git clone git@github.com:rkk/dotfiles.git $HOME
    $ ~/dotfiles.install.sh
    $ ~/.vim/install.sh

## Bug reports
Bug reports, suggestions and feedback is highly appreciated.  
Send a pull request or [message me](https://github.com/rkk).
