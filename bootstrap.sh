#!/bin/sh -f

# Fetch separate modules
command -v git || { sudo apt update && sudo apt install git; }
git submodule update --recursive --init

# Optionally backup previously existing files
backup()
{
  tgt=$1
  shift
  files="$*"

  mkdir -p backup
  for f in "${files}"; do
    test -L "${tgt}/$f" || mv "${tgt}/$f" backup/
  done
}

# Each package has a different target directory
command -v stow || { sudo apt update && sudo apt install stow; }

backup ~ .profile
stow -vv -t ~ bashrc

backup ~ .starship.toml
stow -vv -t ~ starship

backup ~ .git-zappware-config .gitconfig
stow -vv -t ~ gitconfig

stow -vv -t ~/.config/nvim neovim

stow -vv -t ~/.config/devbox devbox
