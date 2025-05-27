#!/bin/sh

bare_repo="${1:-$HOME/.local/share/dotfiles}"

tempdir=$(mktemp -d /tmp/dotfiles-setup.XXXXXX) || exit 1

pushd ${bare_repo}

# temporary directory for the worktree
git worktree add -b main --lock --reason "this is my HOME directory" "${tempdir}"

# manually move the worktree to the HOME directory
echo "${base_repo}/worktrees/dotfiles" > ~/.git

echo "${HOME}/.git" > worktree/dotfiles/gitdir

popd
