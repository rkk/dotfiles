#!/bin/bash
#
# Installs the apps, dotfiles and whatnot.
# Requires Homebrew, and installs Cask.
#

## Brew packages to install.
brew_packages="tmux watch gnu-tar reattach-to-user-namespace"
brew_packages="${brew_packages} tig w3m wget"
brew_packages="${brew_packages} shellcheck mksh ctags docker"

brew_cmd="/usr/local/bin/brew"
FONT_ROOT="${HOME}/Library/Fonts"

if [ "$(uname)" != "Darwin" ]; then
    echo "Unsupported operating system"
    exit 2
fi

if [ ! -f ${brew_cmd} ]; then
  echo "ERROR: Homebrew is not installed"
  exit 1
fi

${brew_cmd} update
update_res="${?}"
if [ "${update_res}" -ne 0 ]; then
    echo "ERROR: Cannot update Homebrew"
    exit 1
fi

for p in ${brew_packages}
do
  ${brew_cmd} install "${p}"
  install_res="${?}"
  if [ "${install_res}" -ne 0 ]; then
    echo "ERROR: Cannot install brew package ${p}"
  fi
done

TMUX_HIGHLIGHT_HOME="${HOME}/Frameworks/tmux-prefix-highlight"
if [ ! -d "${TMUX_HIGHLIGHT_HOME}" ]; then
  mkdir -p "${TMUX_HIGHLIGHT_HOME}"
  git clone https://github.com/tmux-plugins/tmux-prefix-highlight.git "${TMUX_HIGHLIGHT_HOME}"
  clone_res="${?}"
  if [ "${clone_res}" -ne 0 ]; then
    echo "ERROR: Cannot clone tmux-prefix-highlight repository"
  fi
fi


if [ ! -d "${FONT_ROOT}" ]; then
    mkdir -p "${FONT_ROOT}"
fi
font_tar="${TMPDIR}/ttfs.tar.gz"
curl -sS "https://go.googlesource.com/image/+archive/master/font/gofont/ttfs.tar.gz" > "${font_tar}"
tar xzf "${font_tar}" -C "${FONT_ROOT}"
if [ -f "${font_tar}" ]; then
    rm -f "${font_tar}"
fi

# Fuzzy Finder (fzf).
if [ ! -d "${HOME}/.fzf" ]; then
    git clone https://github.com/junegunn/fzf.git ~/.fzf
fi


echo ""
echo "Installation completed."
echo ""

