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


# Detectar shell y agregar PATH al archivo de configuración si no existe
shell_name=$(basename "$SHELL")
case "$shell_name" in
	bash)
		shell_rc="$HOME/.bashrc"
		;;
	zsh)
		shell_rc="$HOME/.zshrc"
		;;
	fish)
		shell_rc="$HOME/.config/fish/config.fish"
		;;
	*)
		shell_rc="$HOME/.profile"
		;;
esac


echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> "$shell_rc"
echo 'eval "$(mise activate bash)"' >> "$shell_rc"
echo "\n[INFO] Se añadió mise/shims al PATH en $shell_rc"

# ensure config directory exists
mkdir -p "${HOME}"/.config/mise/

# create config symlink
ln -sfv "$(cd "$(dirname "$0")/.." && pwd)/mise/config.toml" "${HOME}"/.config/mise/config.toml

# update plugins
mise plugin update

# install tools
mise install

mise reshim
mise ls --installed --quiet | awk '{print $1}' | xargs -I {} mise use -g {}