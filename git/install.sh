#!/bin/bash

# Cargar variables desde el archivo .env si existe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Configurar Git con las variables del archivo .env
if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ]; then
  echo "Error: Las variables GIT_USER_NAME y GIT_USER_EMAIL deben estar configuradas en el archivo .env."
  exit 1
fi

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"

# Crear enlaces simbólicos para los archivos de configuración
mkdir -p "$HOME/.git"
ln -sfv ./git/.gitconfig "$HOME/.git"
ln -sfv ./git/bin "$HOME/.git"

echo "Configuración de Git instalada correctamente."
