# DOTFILES
Automated installation and configuration for a terminal-centric
Linux working environment,

  - Tiling X11 window manager, with keyboard-focused interaction ([i3](i3)).
  - Bright color schemes, no syntax highlighting.
  - Vim editor with code navigation and Git integration, for [Go](golang) development.
  - Custom programming-optimized [keyboard layout](dvorarkk).

See the list of included programs in the Scope section.

## SUPPORTED PLATFORMS
Only Debian Linux is supported, but Debian-derived distributions
such us Ubuntu may work.

## INSTALLATION
Clone this repository to your home directory and run the install
script in your normal user account,

    # cd $HOME
    # git clone --bare https://github.com/rkk/dotfiles .dotfiles
    # git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f
    # ./dotfiles.install.sh --all

Note: Existing configuration files in your home directory will be
overwritten. Omit the parameter "-f" from the checkout command to
avoid this.

You will be prompted for a Sudo password, when the installation
scripts starts.  
The installation script is idempotent, so running it multiple times
causes no issues.

Once the installation scripts successfully complete, the configuration
will be live the next time you log in.


## DESIGN AND IMPLEMENTATION
Most dotfiles implementations combine a version control system
that stores files in one location, with dotfiles management
software that performs the linking from that location into the
home directory.

Whilst dotfiles management solutions undoubtedly works wonders
for others, I prefer simpler solutions with fewer moving parts.

One such solution is the [Git bare repository](gitbare)
approach, with the work tree checked out in the home directory.
This accomplishes the same goals, with vanilla Git functionality
and without extra software components.

## CAVEATS
Beware the following before perusing this,

  - The configuration embodies _my_ personal preferences; you may not agree to these.
  - Personal or sensitive information is omitted, as it is managed outside Git. You may need to do the same with your personal information.

## SCOPE
The following applications are installed and configured by this,

  - X11: i3, sxhkd, Polybar, Rofi, Dmenu, xdotool, wmctrl.
  - Editors: Vim, Gvim.
  - Development: Docker, Terraform, Go, Python.
  - Terminals and shells: XTerm, Unicode-RXVT, tmux, Bash.
  - Browsers: Firefox, Chromium, w3m.
  - Fonts: Microsoft and Go fonts.

The master branch is kept stable - any experimental changes are restricted
to feature or host-specific branches, named "feature/NAME" and
"host/NAME", respectively.


## KEYBOARD SHORTCUTS
As this is a keyboard-centric configuration, a list of the most used shortcuts
is appropriate.

The design is based on Vi shortcuts,

  * d for delete
  * h, j, k, l for movement.
  * / for search

Outside the Vi realm, modifier keys are needed to invoke the desired action,
with the following scheme,

  * Primary modifier + key: Primary action with item (e.g. focus window)
  * Primary plus secondary modifier + key: Secondary action with item (e.g. move window)

For the modifiers, the X11 modifier naming convention is used in the following meaning,

  * Super key: Windows key (see `.config/sxhkdrc/i3.sxhkdrc`)
  * Control key: Normal Control key, but mapped to Caps Lock (see `.config/dvorarkk/X11/dvorarkk.xmodmap`)
  * Mode key: Right Alt key  (see `.config/dvorarkk/X11/dvorarkk.xmodmap`)

Keyboard shortcuts are not limited to a single key-modifier pair, but may be a sequence
of key-modifier pairs or keys. An example is `Control + b, {h,l,j,k}` from Tmux that
means Control and b pressed and released at the same time, following by pressing one
of the keys h, l, j or k.

Reducing the amount of simultaneously pressed keys is an overall design goal, as that
reduces the muscle strain, especially on the lesser used fingers, and avoids stretching
fingers to both reach and press.


### Window manager operations

  * Focus window left, right, up or down: Super + {h,l,j,k}
  * Move window left, right, up or down: Super + Shift + {h,l,j,k}
  * Focus workspace N (1 to 4): Super + N
  * Move window to workspace N (1 to 4): Super + Shift + N or Control + Shift, N
  * Toggle fullscreen of currently focused window: F11
  * Close currently focused window: Super + w or Control + Space, w
  * Kill application of currently focused window: Super + q
  * Resize currently focused window, growing left, right, up or down: Control + Space, {arrow key left, right, up, down}
  * Change window split orientation for new windows to horisontal or vertical: Control + Space, {h,v}

### Terminal window and pane operations

  * Focus pane left, right, up and down: Control + b, {h,l,j,k}
  * Focus the previously focused pane: Control + b, Tab
  * Focus the previously focused window: Control + b, Enter
  * Create new window: Control + b, c
  * Create new vertical pane: Control + b, -
  * Create new horisontal pane: Control + b, |


## BUG REPORTS
Bug reports and pull requests are highly appreciated.


## CREDITS
Many thanks to Drew DeVault and the blog post
["Managing my dotfiles as a Git Repository"](drewdotfiles),
demonstrating this lean way of using Git to track dotfiles without needing dotfiles
management software.


## LICENSE
This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.

[i3]: https://i3wm.org
[golang]: https://golang.org
[dvorarkk]: https://github.com/rkk/Dvorarkk
[gitbare]: https://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/
[drewdotfiles]: https://drewdevault.com/2019/12/30/dotfiles.html


