.PHONY: terminator git mise nvim starship vscode dependencies install 
default: .PHONY

terminator:
	@echo "🚀 \\e[1;34mInstalando configuración de Terminator...\\e[0m"
	@mkdir -p ~/.config/terminator
	@cp terminator/config ~/.config/terminator/config
	@echo "✅ \\e[1;32mConfiguración de Terminator instalada correctamente.\\e[0m"

git:
	@echo "🚀 \\e[1;34mInstalando configuración de Git...\\e[0m"
	@chmod +x git/install.sh
	@./git/install.sh
	@echo "✅ \\e[1;32mConfiguración de Git instalada correctamente.\\e[0m"

mise: 
	@echo "🚀 \\e[1;34mInstalando configuración de Mise...\\e[0m"
	@chmod +x mise/install.sh
	@./mise/install.sh
	@echo "✅ \\e[1;32mConfiguración de Mise instalada correctamente.\\e[0m"

nvim: mise
	@echo "🚀 \\e[1;34mInstalando configuración de Neovim...\\e[0m"
	@chmod +x nvim/install.sh
	@./nvim/install.sh
	@echo "✅ \\e[1;32mConfiguración de Neovim instalada correctamente.\\e[0m"
.PHONY: starship
starship: 
	@echo "🚀 \\e[1;34mInstalando configuración de Starship...\\e[0m"
	@chmod +x starship/install.sh
	@./starship/install.sh
	@echo "✅ \\e[1;32mConfiguración de Starship instalada correctamente.\\e[0m"

vscode: 
	@echo "🚀 \\e[1;34mInstalando configuración de VSCode...\\e[0m"
	@chmod +x vscode/install.sh
	@./vscode/install.sh
	@echo "✅ \\e[1;32mConfiguración de VSCode instalada correctamente.\\e[0m"

.PHONY: dependencies
dependencies:
	@echo "🚀 \\e[1;34mInstalando dependencias necesarias...\\e[0m"
	@bash ./dependencies.sh
	@echo "✅ \\e[1;32mDependencias instaladas correctamente.\\e[0m"

.PHONY: install
install: dependencies terminator git mise nvim starship vscode
	@echo "🎉 \\e[1;32mInstalación completa de todas las configuraciones.\\e[0m"

.PHONY: test

.PHONY: test test-%

test:
	docker run --rm -v $(PWD):/dotfiles -w /dotfiles ubuntu:latest bash -c \
		"export CI=true && apt update && apt install -y build-essential && make install"

test-%:
	docker run --rm -v $(PWD):/dotfiles -w /dotfiles ubuntu:latest bash -c \
		"export CI=true && apt update && apt install -y build-essential && make $*"
