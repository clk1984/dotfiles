#!/usr/bin/env bash
set -ex

# ensure config directory exists
mkdir -p "${HOME}"/.config/mise/

# create config symlink
ln -sfv ./mise/config.toml "${HOME}"/.config/mise/config.toml

# update plugins
mise plugin update

# install tools
mise install

# update tools
mise up
