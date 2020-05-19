#!/bin/bash

set -e
set -x

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

main_dir=$(pwd)
# echo "$main_dir"

while IFS= read -r root_file
do
    dir=$(dirname "$root_file")
    filename=$(basename "$root_file")
    cd "$dir"
    "$compiler" $args "$filename"
    "$compiler" "-c"
    cd "$main_dir"
done < <(printf '%s\n' "$files")



