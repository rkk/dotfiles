# Dotfiles

Unix-style configuration files for a terminal-centric working
environment,

  - Bash running in the [Tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer
  - [i3 tiling window manager](https://i3wm.org/) and plain Xterm using [Solarized Dark](http://ethanschoonover.com/solarized)
  - Vim editor with code navigation features and Git integration, focused on [Golang](https://golang.org/) development
  - Custom programming-optimized [keyboard layout](https://github.com/rkk/Dvorarkk)
  - Programming and Unix-oriented feeds in [Newsbeuter](https://newsbeuter.org/) terminal RSS client

# Platforms
The primary platforms are OpenBSD and Debian-derived Linux distributions,
but contents are also tested on Mac OS X (10.10+), where applicable and feasible.

# Installation
Run the setup script pertaining to your platform, eg. `setup.linux.sh`
for Linux, `setup.openbsd.sh` for OpenBSD and such.  
The script is idempotent, so running it numerous times will do no harm.

Once setup has run, install the dotfiles by means of running the installation
script `install-symlink.sh`, in either `desktop` or `laptop` mode. Desktop mode expects
multiple displays and cares little about power management options. Laptop
mode is the opposite.

This repository has a number of Git branches named `host/X`, that are
configurations tailored towards a specific host. These are considered
experimental and provide no backwards compability.

## Manual installation
Manual installation of is also supported, by means of copying or symlinking
the respective directory contents to your local files, e.g,

    $ git clone git@github.com:rkk/dotfiles.git $HOME/dotfiles
    $ ln -s ~/dotfiles/Tmux/dot.tmux.conf ~/.tmux.conf

If more elaborate installation steps are required, consult the README
in the respective subdirectory, if available.


# Bug reports
Bug reports, suggestions and feedback is highly appreciated.  
Send a pull request or [message me](https://github.com/rkk).
