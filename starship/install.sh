#!/usr/bin/env bash
set -ex

# create .starship folder, if not exist
mkdir -p "${HOME}"/.starship

# create symlinks for starship.toml config file
ln -sfv ./starship/starship.toml "${HOME}"/.starship
# create symlinks for helper scripts
