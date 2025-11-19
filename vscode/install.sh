#!/bin/bash
set -ex

# create symlinks
ln -sfv ./vscode/settings.json "${HOME}"/.config/Code/User/settings.json

# sort settings.json
UUID=$(uuidgen)
jq --sort-keys < ./vscode/settings.json > /tmp/"${UUID}"
mv /tmp/"${UUID}" ./vscode/settings.json

# update extensions
code --update-extensions