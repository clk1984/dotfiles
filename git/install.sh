#!/usr/bin/env bash
set -ex


# create new git folder
mkdir -p "${HOME}"/.git

# create symlinks
ln -sfv ./git/.gitconfig "${HOME}/.git"
ln -sfv ./git/bin "${HOME}"/.git
