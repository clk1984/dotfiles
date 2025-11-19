#!/usr/bin/env bash
set -ex

# Instalar mise si no existe
if ! command -v mise &> /dev/null; then
	echo "Instalando mise desde el repositorio oficial..."
	if [[ "$CI" == "true" ]]; then
		apt update -y && apt install -y curl
		install -dm 755 /etc/apt/keyrings
		curl -fSs https://mise.jdx.dev/gpg-key.pub | tee /etc/apt/keyrings/mise-archive-keyring.pub 1> /dev/null
		echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.pub arch=amd64] https://mise.jdx.dev/deb stable main" | tee /etc/apt/sources.list.d/mise.list
		apt update
		apt install -y mise
	else
		sudo apt update -y && sudo apt install -y curl
		sudo install -dm 755 /etc/apt/keyrings
		curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.pub 1> /dev/null
		echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.pub arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
		sudo apt update
		sudo apt install -y mise
	fi
fi

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
