#!/bin/bash

# Cargar variables desde el archivo .env si existe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Lista de dependencias necesarias
DEPENDENCIES=(
  git
  neovim
  curl
  wget
  zsh
)

# Función para instalar dependencias
install_dependencies() {
  echo "Actualizando lista de paquetes..."
  sudo apt update -y

  echo "Instalando dependencias..."
  for package in "${DEPENDENCIES[@]}"; do
    if dpkg -l | grep -q "^ii  $package "; then
      echo "$package ya está instalado."
    else
      echo "Instalando $package..."
      sudo apt install -y "$package"
    fi
  done

  echo "Instalando Mise..."
  if ! command -v mise &> /dev/null; then
    sudo install -dm 755 /etc/apt/keyrings
    curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.pub 1> /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.pub arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update
    sudo apt install -y mise
  else
    echo "Mise ya está instalado."
  fi

  echo "Instalando Starship..."
  if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
  else
    echo "Starship ya está instalado."
  fi

  echo "Limpieza de paquetes innecesarios..."
  sudo apt autoremove -y
}

# Validar que el sistema operativo sea compatible
if ! grep -qi "debian" /etc/os-release; then
  echo "Este script solo es compatible con sistemas basados en Debian (como Ubuntu)."
  exit 1
fi

# Ejecutar la función
install_dependencies