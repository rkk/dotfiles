# Use .bashrc instead.
if [ -f "${HOME}/.bashrc" ]; then
    # shellcheck disable=SC1090
    source "${HOME}/.bashrc"
fi
