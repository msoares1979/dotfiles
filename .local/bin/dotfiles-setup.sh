#!/bin/sh

bare_repo="${1:-$HOME/.local/share/dotfiles}"

git init --bare ${bare_repo}

if [ ! -f ${HOME}/.local/bin/dotfiles-setup.sh ]; then
	echo "Do you want to checkout the dotfiles repository? (y/n)"
	read -r answer
	if [ "${answer}" = "y" ]; then
		[ -d ${HOME}/.config ] && mv ${HOME}/.config ${HOME}/.config-backup
		git --git-dir=${bare_repo} --work-tree=${HOME} checkout --force
	fi
fi
