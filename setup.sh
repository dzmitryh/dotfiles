#!/usr/bin/env bash

dotfiles=("zshrc" "gitconfig")
dir="${HOME}/dotfiles"

for dotfile in "${dotfiles[@]}"
do
 echo "making symlink for ${dotfile}"
 ln -sf "${dir}/${dotfile}" "${HOME}/.${dotfile}"
done
