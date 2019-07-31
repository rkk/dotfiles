#!/bin/bash
#
# Configures the directory structure, installs the Pathogen package
# manager and the needed bundles.

set -e

VIM_ROOT="${HOME}/.vim"
BUNDLE_ROOT="${HOME}/.vim/bundle"
AUTOLOAD_ROOT="${HOME}/.vim/autoload"
PATHOGEN_VIM="${AUTOLOAD_ROOT}/pathogen.vim"
BACKUP_ROOT="${HOME}/.vim/backup"
TMP_ROOT="${HOME}/.vim/tmp"

# Assume this repo can be used for Vim.
if [ ! -d "${VIM_ROOT}" ]; then
    ln -sf "${PWD}" "${VIM_ROOT}"
fi

if [ ! -d "${BUNDLE_ROOT}" ]; then
    mkdir -p "${BUNDLE_ROOT}"
fi

if [ ! -d "${AUTOLOAD_ROOT}" ]; then
    mkdir -p "${AUTOLOAD_ROOT}"
fi

if [ ! -d "${BACKUP_ROOT}" ]; then
    mkdir -p "${BACKUP_ROOT}"
fi

if [ ! -d "${TMP_ROOT}" ]; then
    mkdir -p "${TMP_ROOT}"
fi

if [ ! -f "${PATHOGEN_VIM}" ]; then
    curl -LSso "${PATHOGEN_VIM}" https://tpo.pe/pathogen.vim
fi


# Fugitive
if [ ! -d "${BUNDLE_ROOT}/vim-fugitive" ]; then
    git clone git://github.com/tpope/vim-fugitive.git "${BUNDLE_ROOT}/vim-fugitive"
fi

# Tagbar
if [ ! -d "${BUNDLE_ROOT}/tagbar" ]; then
    git clone git://github.com/majutsushi/tagbar.git "${BUNDLE_ROOT}/tagbar"
fi

# Goyo
if [ ! -d "${BUNDLE_ROOT}/goyo" ]; then
    git clone git://github.com/junegunn/goyo.vim.git "${BUNDLE_ROOT}/goyo"
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

# Syntastic
if [ ! -d "${BUNDLE_ROOT}/syntastic" ]; then
    git clone --depth=1 git://github.com/vim-syntastic/syntastic.git "${BUNDLE_ROOT}/syntastic"
fi

# Supertab
if [ ! -d "${BUNDLE_ROOT}/supertab" ]; then
    git clone git://github.com/ervandew/supertab.git "${BUNDLE_ROOT}/supertab"
fi

# Vim-Surround
if [ ! -d "${BUNDLE_ROOT}/vim-surround" ]; then
    git clone git://github.com/tpope/vim-surround.git "${BUNDLE_ROOT}/vim-surround"
fi

# Rainbow delimiters
if [ ! -d "${BUNDLE_ROOT}/rainbow_parentheses" ]; then
    git clone git://github.com/kien/rainbow_parentheses.vim.git" ${BUNDLE_ROOT}/rainbow_parentheses"
fi

