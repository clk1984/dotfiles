# Función específica para instalar Godot Engine
install_godot() {
  print_configuration_message "Instalando Godot Engine (última versión estable)..."
  GODOT_URL=$(curl -s https://api.github.com/repos/godotengine/godot/releases/latest | grep browser_download_url | grep 'linux.x86_64.zip' | cut -d '"' -f4 | head -n1)
  if [ -z "$GODOT_URL" ]; then
    echo -e "\e[1;31mNo se pudo obtener la URL de la última versión de Godot.\e[0m"
    return 1
  fi
  wget -O godot.zip "$GODOT_URL"
  unzip -o godot.zip -d godot_bin
  GODOT_EXE=$(find godot_bin -type f -name 'Godot*' | head -n1)
  if [ -z "$GODOT_EXE" ]; then
    echo -e "\e[1;31mNo se encontró el ejecutable de Godot tras la descarga.\e[0m"
    rm -rf godot.zip godot_bin
    return 1
  fi
  if command -v sudo &> /dev/null; then
    sudo mv "$GODOT_EXE" /usr/local/bin/godot
    sudo chmod +x /usr/local/bin/godot
  else
    mkdir -p "$HOME/.local/bin"
    mv "$GODOT_EXE" "$HOME/.local/bin/godot"
    chmod +x "$HOME/.local/bin/godot"
    export PATH="$HOME/.local/bin:$PATH"
  fi
  rm -rf godot.zip godot_bin
  echo -e "✅ \e[1;32mGodot Engine instalado y disponible como comando global 'godot'.\e[0m"
}
#!/bin/bash

# Cargar variables desde el archivo .env si existe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Asegurarse de que la variable CI esté configurada como "true" en los entornos de prueba
if [ -z "$CI" ]; then
  export CI=false
fi

# Lista de dependencias necesarias
DEPENDENCIES=(
  git
  neovim
  curl
  wget
  zsh
  vim
  make
  gcc
  g++
  python3
  python3-pip
  build-essential
  nmap
  net-tools
  openssh-server
  htop
  tmux
  tree
  unzip
  zip
  terminator
  obsidian
  code # Visual Studio Code
  krita
)

# Lista de herramientas secundarias opcionales
SECONDARY_TOOLS=(
  steam
  discord
)

# Lista de herramientas con sus comandos de verificación y mensajes
TOOLS=(
  "git:command -v git:\e[1;32mConfiguración de Git instalada correctamente.\e[0m"
  "neovim:command -v nvim:\e[1;32mConfiguración de Neovim instalada correctamente.\e[0m"
  "curl:command -v curl:\e[1;32mConfiguración de Curl instalada correctamente.\e[0m"
  "wget:command -v wget:\e[1;32mConfiguración de Wget instalada correctamente.\e[0m"
  "zsh:command -v zsh:\e[1;32mConfiguración de Zsh instalada correctamente.\e[0m"
  "vim:command -v vim:\e[1;32mConfiguración de Vim instalada correctamente.\e[0m"
  "make:command -v make:\e[1;32mConfiguración de Make instalada correctamente.\e[0m"
  "gcc:command -v gcc:\e[1;32mConfiguración de GCC instalada correctamente.\e[0m"
  "g++:command -v g++:\e[1;32mConfiguración de G++ instalada correctamente.\e[0m"
  "python3:command -v python3:\e[1;32mConfiguración de Python 3 instalada correctamente.\e[0m"
  "python3-pip:command -v pip3:\e[1;32mConfiguración de Pip para Python 3 instalada correctamente.\e[0m"
  "docker-ce:command -v docker:\e[1;32mConfiguración de Docker instalada correctamente.\e[0m"
  "docker-compose-plugin:docker compose version:\e[1;32mConfiguración de Docker Compose instalada correctamente.\e[0m"
)

# Función para imprimir cabeceras
print_header() {
  local header=$1
  echo -e "\n\e[1;34m========== 🚀 $header ==========
\e[0m"
}

# Función para imprimir mensajes destacados
print_secondary_tool_message() {
  local message=$1
  echo -e "\e[1;33m⚠️ $message\e[0m"
}

# Función para imprimir mensajes llamativos para configuraciones
print_configuration_message() {
  local message=$1
  echo -e "\e[1;36m🔧 $message\e[0m"
}

# Función para verificar si una herramienta está instalada
check_and_install() {
  local package=$1
  local check_command=$2
  local success_message=$3

  print_header "Configurando $package"

  if eval "$check_command &> /dev/null"; then
    echo -e "✅ $success_message"
  else
    echo "⚙️ Instalando $package..."
    if [ "$package" == "discord" ]; then
      install_discord
    else
      if command -v sudo &> /dev/null; then
        sudo apt install -y "$package"
      else
        apt install -y "$package"
      fi
    fi
    if eval "$check_command &> /dev/null"; then
      echo -e "✅ $success_message"
    else
      echo -e "\e[1;31mHubo un problema al instalar $package.\e[0m"
    fi
  fi
}

# Función específica para instalar Docker
install_docker() {
  print_configuration_message "Configurando el repositorio oficial de Docker..."
  if command -v sudo &> /dev/null; then
    sudo apt update
    sudo apt install -y ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
  else
    apt update
    apt install -y ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
  fi

  print_configuration_message "Añadiendo el repositorio de Docker a las fuentes de Apt..."
  if command -v sudo &> /dev/null; then
    sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
  else
    tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
  fi

  print_configuration_message "Instalando Docker y sus componentes..."
  if command -v sudo &> /dev/null; then
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  else
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  fi
}

# Función específica para instalar Discord
install_discord() {
  print_secondary_tool_message "Descargando Discord..."
  wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
  print_secondary_tool_message "Instalando Discord..."
  if command -v sudo &> /dev/null; then
    sudo dpkg -i discord.deb
    sudo apt-get install -f -y # Resolver dependencias
  else
    dpkg -i discord.deb
    apt-get install -f -y # Resolver dependencias
  fi
  rm -f discord.deb
}

# Función para instalar dependencias
install_dependencies() {
  print_header "1. Instalación de dependencias del sistema"

  print_header "1.1 Dependencias básicas"
  if command -v sudo &> /dev/null; then
    sudo apt update -y
  else
    apt update -y
  fi

  echo "Instalando dependencias básicas..."
  for tool in "${TOOLS[@]}"; do
    IFS=":" read -r package check_command success_message <<< "$tool"
    if [[ "$package" == "docker-ce" ]]; then
      install_docker
    else
      check_and_install "$package" "$check_command" "$success_message"
    fi
  done

  # Instalar Godot Engine
  install_godot

  print_header "1.2 Herramientas secundarias"
  if [[ "$CI" == "true" ]]; then
    print_secondary_tool_message "Entorno de prueba detectado. Instalando herramientas secundarias automáticamente..."
    for tool in "${SECONDARY_TOOLS[@]}"; do
      check_and_install "$tool" "dpkg -l | grep -q ^ii.*$tool" "\e[1;32mConfiguración de $tool instalada correctamente.\e[0m"
    done
  else
    print_secondary_tool_message "¿Deseas instalar herramientas secundarias como Steam y Discord? (s/n)"
    read -r install_secondary

    if [[ "$install_secondary" =~ ^[sS]$ ]]; then
      print_secondary_tool_message "Instalando herramientas secundarias..."
      for tool in "${SECONDARY_TOOLS[@]}"; do
        check_and_install "$tool" "dpkg -l | grep -q ^ii.*$tool" "\e[1;32mConfiguración de $tool instalada correctamente.\e[0m"
      done
    else
      print_secondary_tool_message "Herramientas secundarias omitidas."
    fi
  fi

  print_header "2. Configuración de herramientas"
  print_configuration_message "Configurando herramientas instaladas..."

  print_configuration_message "Configurando Docker para ejecutarse sin root..."
  if command -v sudo &> /dev/null; then
    sudo groupadd docker || true
    sudo usermod -aG docker "$USER"
    print_configuration_message "Es necesario reiniciar la sesión para aplicar los cambios de Docker."
    print_configuration_message "Limpieza de paquetes innecesarios..."
    sudo apt autoremove -y
  else
    groupadd docker || true
    usermod -aG docker "$USER"
    print_configuration_message "Es necesario reiniciar la sesión para aplicar los cambios de Docker."
    print_configuration_message "Limpieza de paquetes innecesarios..."
    apt autoremove -y
  fi
}

# Validar que el sistema operativo sea compatible
if ! grep -qi "debian" /etc/os-release; then
  echo "Este script solo es compatible con sistemas basados en Debian (como Ubuntu)."
  exit 1
fi

# Ejecutar la función
install_dependencies