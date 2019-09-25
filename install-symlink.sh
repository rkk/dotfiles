#!/bin/sh
#
# Installs dotfiles in all platforms.
# The script is designed to be idempotent, so no
# side effects are expected if run multiple times.
#
# The script runs in either desktop or laptop mode, and
# defaults to desktop.


if [ "${#}" -ne 1 ]; then
    name=$(basename "${0}")
    echo "Usage: ${name} <desktop|laptop>"
    echo ""
    echo "Installs dotfiles in all supported platforms, and is idempotent,"
    echo "so no side effects are expected if run multiple times."
    echo""
    echo "Supported platforms,"
    echo "  - OpenBSD"
    echo "  - Linux"
    echo "  - Mac OS X"
    echo ""
    exit 0
fi

mode="${1}"
os="$(uname)"

case ${os} in
    "Linux"|"OpenBSD"|"Darwin")
        ;;
     *)
         echo "ERROR: Unsupported operating system"
         exit 1
         ;;
 esac



#
# COMMON FOR ALL PLATFORMS.
#

bash_config_src="${PWD}/Bash/dot.bashrc"
bash_config_dst="${HOME}/.bashrc"

if [ ! -f "${bash_config_dst}" ]; then
    ln -sf "${bash_config_src}" "${bash_config_dst}"
    link_res=${?}
    if [ ${link_res} -ne 0 ]; then
        echo "ERROR: Cannot install Bash source ${bash_config_src} to destination ${bash_config_dst}"
    fi
fi
if [ ! -f "${HOME}/.profile" ]; then
    ln -sf "${bash_config_src}" "${HOME}/.profile"
    profile_res=${?}
    if [ ${profile_res} -ne 0 ]; then
        echo "ERROR: Cannot install Bash source ${bash_config_src} to destination ~/.profile"
    fi 
fi

git_config_src="${PWD}/Gitconfig/dot.gitconfig"
git_config_dst="${HOME}/.gitconfig"
if [ ! -f "${git_config_dst}" ]; then
    ln -sf "${git_config_src}" "${git_config_dst}"
    link_res=${?}
    if [ ${link_res} -ne 0 ]; then
        echo "ERROR: Cannot install Git source ${git_config_src} to destination ${git_config_dst}"
    fi
fi

news_config_src="${PWD}/Newsbeuter"
news_config_dst="${HOME}/.config/newsbeuter"

if [ ! -d "${news_config_dst}" ]; then
    ln -sf "${news_config_src}" "${news_config_dst}"
    link_res=${?}
    if [ ${link_res} -ne 0 ]; then
        echo "ERROR: Cannot install Newsbeuter source ${news_config_src} to destination ${news_config_dst}"
    fi
fi

# Tmux terminal multiplexer.
tmux_config_src="${PWD}/Tmux/dot.tmux.conf"
tmux_config_dst="${HOME}/.tmux.conf"

if [ ! -f "${tmux_config_dst}" ]; then
    ln -sf "${tmux_config_src}" "${tmux_config_dst}"
    link_res=${?}
    if [ ${link_res} -ne 0 ]; then
        echo "ERROR: Cannot install Tmux source ${tmux_config_src} to destination ${tmux_config_dst}"
    fi
fi

# Vim editor and plugins.
startDir="${PWD}"
cd Vim || return
./install.sh
cd "${startDir}" || return


#
# SPECIFIC PLATFORMS.
#

os="$(uname)"

case ${os} in
    "Linux"|"OpenBSD")

    # i3 window manager and i3status status panel.
    i3_config_src="${PWD}/I3"
    i3_config_dst="${HOME}/.config/i3"
    i3_mode_dst="${i3_config_dst}/config"
    status_config_src="${PWD}/I3status"
    status_config_dst="${HOME}/.config/i3status"

    if [ ! -d "${i3_config_dst}" ]; then
        ln -sf "${i3_config_src}" "${i3_config_dst}"
        link_res=${?}
        if [ ${link_res} -ne 0 ]; then
            echo "ERROR: Cannot install i3 source ${i3_config_src} to destination ${i3_config_dst}"
        fi
    fi
    if [ ! -f "${i3_mode_dst}" ]; then
        if [ -f "${i3_config_src}/config.${mode}" ]; then
            ln -sf "${i3_config_src}/config.${mode}" "${i3_mode_dst}"
        fi
    fi
    if [ ! -d "${status_config_dst}" ]; then
        ln -sf "${status_config_src}" "${status_config_dst}"
        link_res=${?}
        if [ ${link_res} -ne 0 ]; then
            echo "ERROR: Cannot install i3status source ${status_config_src} to destination ${status_config_dst}"
        fi
    fi
    xres_src="${PWD}/X11/dot.Xdefaults"
    xres_dst="${HOME}/.Xdefaults"
    if [ -f "{xres_dst}" ]; then
        ln -sf "${xres_src}" "${xres_dst}"
        link_res="${?}"
        if [ ${link_res} -ne 0 ]; then
            echo "ERROR: Cannot install X11 source ${xres_src} to destination ${xres_dst}"
        fi
    fi
    xsess_src="${PWD}/X11/dot.xsession"
    xsess_dst="${HOME}/.xsession"
    if [ ! -f "{xsess_dst}" ]; then
        ln -sf "${xsess_src}" "${xsess_dst}"
        link_res="${?}"
        if [ ${link_res} -ne 0 ]; then
            echo "ERROR: Cannot install X11 source ${xsess_src} to destination ${xsess_dst}"
        fi
    fi

    scripts_src="${PWD}/Scripts"
    scripts_dst="${HOME}/bin"
    if [ ! -d "${scripts_dst}" ]; then
        ln -sf "${scripts_src}" "${scripts_dst}"
        link_res="${?}"
        if [ ${link_res} -ne 0 ]; then
            echo "ERROR: Cannot link Scripts source ${scripts_src} to destination ${scripts_dst}"
        fi
    fi
;;
esac
echo "Done."
