#!/bin/bash
##
## Installs the Slate config files.
##

config_file="${HOME}/.slate.js"
if [ -f $config_file ]; then
  rm -f $config_file
fi

source_file="${PWD}/dot.slate.js"
if [ -f $source_file ]; then
  ln -s $source_file $config_file
  link_res=${?}
  if [ $link_res -ne 0 ]; then
    echo "ERROR: Cannot symlink ${source_file} to ${config_file}"
    exit 1
  fi
fi
