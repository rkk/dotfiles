#!/bin/sh
#
# Bootstrap the dotfiles, handy for plain vanilla
# installs via the dreaded curl | sh method.

dotfiles_repo="https://github.com/rkk/dotfiles.git"
dotfiles_dst="${HOME}/Frameworks/Dotfiles"
if [ ! -d "${dotfiles_dst}" ]; then
    git clone "${dotfiles_repo}" "${dotfiles_dst}"
fi

start_dir="${PWD}"
os="$(uname)"

case ${os} in
    "Linux")
        cd "${dotfiles_dst}" || exit 2
        ./setup.linux.sh
        ./install.sh desktop
        cd "${start_dir}"
        ;;
    "OpenBSD")
         cd "${dotfiles_dst}" || exit 2
        ./setup.openbsd.sh
        # ./install.sh laptop
        cd "${start_dir}"
        ;;
    "Darwin")
         cd "${dotfiles_dst}" || exit 2
        ./setup.macosx.sh
        ./install.sh laptop
        cd "${start_dir}"
    ;;

     *)
         echo "ERROR: Unsupported operating system"
         exit 1
         ;;
 esac

cd "${start_dir}"
echo "\nBootstrap completed"

