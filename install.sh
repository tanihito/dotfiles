#!/bin/bash

IGNORE_FILES=("")
COPY_FILES=("dotgitconfig" "dotssh" "dotemacs.d")

function main {
  for name in `find . -name "dot*" -maxdepth 1 | xargs -n 1 basename`; do

    for ignore_file in ${IGNORE_FILES}; do
      if [ "${name}" == "${ignore_file}" ]; then
        continue 2
      fi
    done

    for copy_file in ${COPY_FILES[@]}; do
      if [ "${name}" == "${copy_file}" ]; then
        make_copy ${name}
        continue 2
      fi
    done

    make_symlink ${name}
  done
}

function make_copy {
  target=`echo $1 | sed -e "s/^dot/./"`
  echo "Making copy    for ${HOME}/${target}"

  if [ ! -e         "${HOME}/${target}" ]; then
    cp -rn "$PWD/$1" "${HOME}/${target}"
  elif [ -L         "${HOME}/${target}" ]; then
    rm              "${HOME}/${target}"
    cp -rn "$PWD/$1" "${HOME}/${target}"
  else
    backup_file=${name}.`date +%Y%m%d%H%M%S`
    echo "Found ${target}. Backing up to ${HOME}/backup/${backup_file}."
    mv "${HOME}/${target}" "${HOME}/backup/${backup_file}"
    cp -rn "$PWD/$1" "${HOME}/${target}"
  fi
}

function make_symlink {
  target=`echo $1 | sed -e "s/^dot/./"`
  echo "Making symlink for ${HOME}/${target}"

  if [ ! -e          "${HOME}/${target}" ]; then
    ln -s  "$PWD/$1" "${HOME}/${target}"
  elif [ -L          "${HOME}/${target}" ]; then
    ln -sf "$PWD/$1" "${HOME}/${target}"
  else
    backup_file=${name}.`date +%Y%m%d%H%M%S`
    echo "${target} exists but is not a symlink. Backing up to ${HOME}/backup/${backup_file}."
    mv "${HOME}/${target}" "${HOME}/backup/${backup_file}"
    ln -s  "$PWD/$1" "${HOME}/${target}"
  fi
}

main