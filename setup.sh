#!/usr/bin/env bash

for f in ~/dotfiles/*
do
  ln -sf "$f" "$HOME/.${f##*/}"
done
