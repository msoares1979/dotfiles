#!/bin/sh

bare_repo="${1:-$HOME/.local/share/dotfiles}"

pushd ${bare_repo}

# temporary directory for the worktree
git worktree add -b main --lock --reason "this is my HOME directory" $HOME/dotfiles

# manually move the worktree to the HOME directory
cp -fv ~/dotfiles/.git ~
sed -i -e 's@/dotfiles@@' ~/.git

echo "${HOME}/.git" > worktree/dotfiles/gitdir

popd



