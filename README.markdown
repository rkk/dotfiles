# Dotfiles

Unix-style configuration files for a terminal-centric working
environment,

  - [Mir Korn Shell](https://www.mirbsd.org/mksh.htm) running in [Tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer
  - [i3 tiling window manager](https://i3wm.org/) and Sakura terminal emulator using [Solarized Dark](http://ethanschoonover.com/solarized)
  - Vim editor with code navigation features and Git integration, focused on [Golang](https://golang.org/) development
  - Custom programming-optimized [keyboard layout](https://github.com/rkk/Dvorarkk)
  - Programming and Unix-oriented feeds in [Newsbeuter](https://newsbeuter.org/) terminal RSS client

## Platforms
Primary platform is Ubuntu Linux, but also tested on Mac OS X (10.10+),
where applicable.

## Installation
Run the setup script to ensure that all dependencies are met. The script
is idempotent, so running it numerous times will do no harm. Please note
that the setup script targets Linux only.  
Copy or symlink the respective directory contents to your local config files, e.g,

    $ ./setup.sh
    $ git clone git@github.com:rkk/dotfiles.git $HOME/dotfiles
    $ ln -s ~/dotfiles/Tmux/dot.tmux.conf ~/.tmux.conf

If more elaborate installation steps are required, consult the README in the respective subdirectory, if available.

## Bug reports
Bug reports, suggestions and feedback is highly appreciated.  
Send a pull request or [message me](https://github.com/rkk).
