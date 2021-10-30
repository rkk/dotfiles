#!/bin/bash
#
# Installs the packages and tools that make up the environment.
# The script is designed to be idempotent, so no side effects
# are expected, if run multiple times.

function usage() {
	cat << EOF
usage: ${0} OPTIONS

    --all         Install all profiles
    --only-devel  Install only the development profile
    --only-x11    Install only the X11 profile

EOF
}

env_script="dotfiles.env.sh"
if [ ! -f "${env_script}" ]; then
	echo "ERROR: Required script ${env_script} not found"
	exit 1
fi

source "${env_script}"

if [ ${#} -eq 0 ]; then
	usage
	exit 0
fi


for opt in "${@}"; do
	case ${opt} in
		--all)
		dotfiles_linux_install_profile_all
		echo ""
		echo "Done."
		;;
		--only-devel)
		dotfiles_linux_install_profile_devel
		echo ""
		echo "Done."
		;;
		--only-x11)
		dotfiles_linux_install_profile_x11
		echo ""
		echo "Done."
		;;
		*)
		echo "Unknown option: ${opt}"
		exit 1
		;;
	esac
done

