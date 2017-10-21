#!/bin/bash
#
# Configures the directory structure, installs the Pathogen package
# manager and the needed bundles.

set -e

BUNDLE_ROOT="${HOME}/.vim/bundle"
AUTOLOAD_ROOT="${HOME}/.vim/autoload"
PATHOGEN_VIM="${AUTOLOAD_ROOT}/pathogen.vim"

if [ ! -d "${BUNDLE_ROOT}" ]; then
    mkdir -p "${BUNDLE_ROOT}"
fi

if [ ! -d "${AUTOLOAD_ROOT}" ]; then
    mkdir -p "${AUTOLOAD_ROOT}"
fi

if [ ! -f "${PATHOGEN_VIM}" ]; then
    curl -LSso "${PATHOGEN_VIM}" https://tpo.pe/pathogen.vim
fi


# Fugitive
if [ ! -d "${BUNDLE_ROOT}/vim-fugitive" ]; then
    git clone https://github.com/tpope/vim-fugitive.git "${BUNDLE_ROOT}/vim-fugitive"
fi

# Tagbar
if [ ! -d "${BUNDLE_ROOT}/tagbar" ]; then
    git clone https://github.com/majutsushi/tagbar.git "${BUNDLE_ROOT}/tagbar"
fi

# Goyo
if [ ! -d "${BUNDLE_ROOT}/goyo" ]; then
    git clone https://github.com/junegunn/goyo.vim.git "${BUNDLE_ROOT}/goyo"
fi

# Vim Commentary
if [ ! -d "${BUNDLE_ROOT}/vim-commentary" ]; then
    git clone git://github.com/tpope/vim-commentary.git "${BUNDLE_ROOT}/vim-commentary"
fi

# Fuzzy Finder for Vim (FZF), requires FZF Github repo to
# be checked out in ~/.fzf and ~/.fzf/install.sh being run beforehand.
if [ ! -d "${BUNDLE_ROOT}/fzf" ]; then
    git clone git://github.com/junegunn/fzf.vim "${BUNDLE_ROOT}/fzf"
fi

# Vim Go
if [ ! -d "${BUNDLE_ROOT}/vim-go" ]; then
    git clone git://github.com/fatih/vim-go.git "${BUNDLE_ROOT}/vim-go"
fi

# NERDTree
if [ ! -d "${BUNDLE_ROOT}/nerdtree" ]; then
    git clone git://github.com/scrooloose/nerdtree "${BUNDLE_ROOT}/nerdtree"
fi

# Git Gutter
if [ ! -d "${BUNDLE_ROOT}/vim-gitgutter" ]; then
    git clone git://github.com/airblade/vim-gitgutter.git "${BUNDLE_ROOT}/vim-gitgutter"
fi

# Solarized
if [ ! -d "${BUNDLE_ROOT}/vim-colors-solarized" ]; then
    git clone git://github.com/altercation/vim-colors-solarized "${BUNDLE_ROOT}/vim-colors-solarized"
fi

