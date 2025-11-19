#!/bin/bash

# Script para instalar la configuración de Terminator

CONFIG_DIR="$HOME/.config/terminator"

# Crear el directorio de configuración si no existe
if [ ! -d "$CONFIG_DIR" ]; then
  mkdir -p "$CONFIG_DIR"
fi

# Copiar el archivo de configuración
cp ./config "$CONFIG_DIR/config"

echo "Configuración de Terminator instalada correctamente."