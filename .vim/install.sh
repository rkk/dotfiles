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


if [ ! -d "${BUNDLE_ROOT}/vim-fugitive" ]; then
    git clone git://github.com/tpope/vim-fugitive.git "${BUNDLE_ROOT}/vim-fugitive"
fi

if [ ! -d "${BUNDLE_ROOT}/tagbar" ]; then
    git clone git://github.com/majutsushi/tagbar.git "${BUNDLE_ROOT}/tagbar"
fi

if [ ! -d "${BUNDLE_ROOT}/goyo" ]; then
    git clone git://github.com/junegunn/goyo.vim.git "${BUNDLE_ROOT}/goyo"
fi

if [ ! -d "${BUNDLE_ROOT}/vim-commentary" ]; then
    git clone git://github.com/tpope/vim-commentary.git "${BUNDLE_ROOT}/vim-commentary"
fi

# Fuzzy Finder for Vim (FZF), requires FZF Github repo to
# be checked out in ~/.fzf and ~/.fzf/install.sh being run beforehand.
if [ ! -d "${BUNDLE_ROOT}/fzf" ]; then
    git clone git://github.com/junegunn/fzf.vim "${BUNDLE_ROOT}/fzf"
fi

if [ ! -d "${BUNDLE_ROOT}/vim-go" ]; then
    git clone git://github.com/fatih/vim-go.git "${BUNDLE_ROOT}/vim-go"
fi

if [ ! -d "${BUNDLE_ROOT}/nerdtree" ]; then
    git clone git://github.com/scrooloose/nerdtree "${BUNDLE_ROOT}/nerdtree"
fi

if [ ! -d "${BUNDLE_ROOT}/vim-gitgutter" ]; then
    git clone git://github.com/airblade/vim-gitgutter.git "${BUNDLE_ROOT}/vim-gitgutter"
fi

if [ ! -d "${BUNDLE_ROOT}/syntastic" ]; then
    git clone --depth=1 git://github.com/vim-syntastic/syntastic.git "${BUNDLE_ROOT}/syntastic"
fi

if [ ! -d "${BUNDLE_ROOT}/supertab" ]; then
    git clone git://github.com/ervandew/supertab.git "${BUNDLE_ROOT}/supertab"
fi

if [ ! -d "${BUNDLE_ROOT}/porter" ]; then
    git clone git://github.com/rkk/porter.git "${BUNDLE_ROOT}/porter"
fi

