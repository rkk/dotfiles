# DOTFILES
Unix-style configuration files for a terminal-centric working
environment,

  - Tiling window managers, with keyboard-focused interaction ([bspwm](bspwm) and [i3](i3)).
  - Black on bright color scheme, no syntax highlighting.
  - Vim editor with code navigation and Git integration, for [Go](golang) development.
  - Custom programming-optimized [keyboard layout](dvorarkk).

See the list of included programs in the Scope section.


## SUPPORTED PLATFORMS
The primary platform is Debian Linux, but contents are
also tested on NetBSD and OpenBSD, where applicable and feasible.


## DESIGN AND IMPLEMENTATION
Most dotfiles implementations combine a version control system
and dotfiles management software to perform the linking of the
version controlled contents to the proper files and
locations in your home directory.

Whilst dotfiles management solutions undoubtedly are great, I
prefer simpler solutions with fewer moving parts.

One such solution is the [Git bare repository](gitbare)
approach, with the work tree checked out in the home directory.
This accomplishes the same goals, with vanilla Git functionality
and without extra software components.


## CAVEATS
There are four important caveats you should be aware of,
before perusing this repository,

  - The configuration reflects my personal preferences; you may not agree to these.
  - The installation instructions assume read/write access to the repository; you may need to either fork the repository to your own Github account or change the repository URL to `https://github.com/rkk/dotfiles.git` when cloning.
  - The Git bare repository approach means you have to run Git with extra parameters, when working on the dotfiles.
  - Git ignores all files, except those explicitly added; that means that Git only tracks files already added, and will ignore any new files created.

Should you tire from adding the parameters required by the bare repository
approach, the script `bin/dotfiles` can be used as a convenient wrapper
around Git, that provides all needed extra parameters for Git.
Use this the same way you would normally run a Git command, e.g., substitute
`git log --name-only` with `dotfiles log --name-only`.

The limitations imposed by the Git bare repository approach, apply only when
working on the dotfiles in your home directory.  Working with Git in any
other directory or subdirectory in your home directory is _not_ affected,
allowing you to run Git like you always do, everywhere else.


## INSTALLATION
Clone this repository to your home directory and run the install
scripts,

    # cd $HOME
    # git clone --bare git@github.com:rkk/dotfiles.git .dotfiles
    # git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

If your home directory already contains files that are included
in this repository, Git will fail.
Remove or rename the offending files, and re-run the Git command.
Add the parameter "-f" to the checkout command if you want any
existing files to be automatically overwritten.
Once Git successfully completes, run the installation script
to install the needed software packages,

    # ./dotfiles.install.sh

This is idempotent, so running it multiple times causes no
issues. But please note that the script requires sudo permission.

Once the installation scripts successfully complete, the configuration
will be live the next time you log in.


## SCOPE
The following applications are supported by means of installation
and configuration,

  - X11: bspwm, i3, sxhkd, Polybar, Rofi, Dmenu, xdotool, wmctrl.
  - Editors: Vim, Gvim, ACME (Linux and OpenBSD only).
  - Development: Docker (Linux only), Terraform, Go, Python.
  - Terminals and shells: XTerm, Sakura, Unicode-RXVT, tmux, Bash.
  - Browsers: Firefox, Chromium (Linux only), w3m.
  - Music: Spotify (Linux only).
  - Fonts: Microsoft and Go fonts.

The master branch is kept stable - any experimental changes are restricted
to feature or host-specific branches, named "feature/NAME" and
"host/NAME", respectively.


## BUG REPORTS
Bug reports and pull requests are highly appreciated.


## CREDITS
Many thanks to Drew DeVault and the blog post
["Managing my dotfiles as a Git Repository"](drewdotfiles),
demonstrating this lean way of using Git to track dotfiles without needing dotfiles
management software.


## LICENSE
This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.

[bspwm]: https://github.com/baskerville/bspwm
[i3]: https://i3wm.org
[golang]: https://golang.org
[dvorarkk]: https://github.com/rkk/Dvorarkk
[gitbare]: https://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/
[drewdotfiles]: https://drewdevault.com/2019/12/30/dotfiles.html


