#!/bin/bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/ghostty

# create symlinks
ln -sfv ./ghostty/config "${HOME}"/.config/ghostty