.PHONY: terminator git mise nvim starship vscode dependencies install
default: .PHONY

terminator:
	@echo "Instalando configuración de Terminator..."
	@mkdir -p ~/.config/terminator
	@cp terminator/config ~/.config/terminator/config
	@echo "Configuración de Terminator instalada correctamente."

git:
	@echo "Instalando configuración de Git..."
	@chmod +x git/install.sh
	@./git/install.sh
	@echo "Configuración de Git instalada correctamente."

mise: 
	@echo "Instalando configuración de Mise..."
	@chmod +x mise/install.sh
	@./mise/install.sh
	@echo "Configuración de Mise instalada correctamente."

nvim: mise
	@echo "Instalando configuración de Neovim..."
	@chmod +x nvim/install.sh
	@./nvim/install.sh
	@echo "Configuración de Neovim instalada correctamente."

starship: 
	@echo "Instalando configuración de Starship..."
	@chmod +x starship/install.sh
	@./starship/install.sh
	@echo "Configuración de Starship instalada correctamente."

vscode: 
	@echo "Instalando configuración de VSCode..."
	@chmod +x vscode/install.sh
	@./vscode/install.sh
	@echo "Configuración de VSCode instalada correctamente."

.PHONY: dependencies
dependencies:
	@echo "Instalando dependencias necesarias..."
	@bash ./dependencies.sh
	@echo "Dependencias instaladas correctamente."

.PHONY: install
install: dependencies terminator git mise nvim starship vscode
	@echo "Instalación completa de todas las configuraciones."
