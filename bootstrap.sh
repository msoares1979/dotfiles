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

backup ~/.config .starship.toml
stow -vv -t ~/.config starship

backup ~ .git-zappware-config .gitconfig
stow -vv -t ~ gitconfig

mkdir -p ~/.config/nvim
stow -vv -t ~/.config/nvim neovim

mkdir -p ~/.config/devbox
stow -vv -t ~/.config/devbox devbox
