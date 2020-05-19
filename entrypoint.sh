#!/bin/bash

set -e

files="$1"
working_directory="$2"
compiler="$3"
args="$4"
extra_system_packages="$5"

if [ -n "$extra_system_packages" ]; then
  apt-get update
  for pkg in $extra_system_packages; do
    echo "Install $pkg by apt"
    apt-get -y install "$pkg"
  done
fi

if [ -n "$working_directory" ]; then
  cd "$working_directory"
fi

while IFS= read -r root_file
do
    echo "$root_file"
   "$compiler" $args "$root_file"
done < <(printf '%s\n' "$files")



