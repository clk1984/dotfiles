[https://github.com/pkissling/dotfiles]: <>
## Dotfiles: Configuración y Automatización

Este repositorio contiene scripts y configuraciones para automatizar la instalación y personalización de herramientas en sistemas Debian/Ubuntu. Cada herramienta tiene su propio script de instalación y configuración.

### Instalación completa

Instala todas las herramientas y configuraciones:

```bash
make install
```

### Instalación individual

Ejecuta solo la configuración de una herramienta:

```bash
make git
make mise
make nvim
make starship
make terminator
make vscode
make zsh
```

### Pruebas automáticas en entorno limpio (Docker)

Testea todo o pasos individuales en un contenedor Ubuntu:

```bash
make test           # Testea todo (make install)
make test-git       # Testea solo git
make test-nvim      # Testea solo nvim
make test-starship  # Testea solo starship
```

---

## Herramientas y scripts

A continuación se detalla qué hace cada script de instalación y cómo usarlo:

### git
- Instala y configura Git.
- Crea enlaces simbólicos para el archivo de configuración (`.gitconfig`).
- Ejecuta el script `git/install.sh` para personalizar alias, hooks y opciones.
- Uso:
	```bash
	make git
	make test-git
	```

### mise
- Instala el gestor de versiones y herramientas [mise](https://mise.jdx.dev/).
- Descarga e instala mise si no está presente.
- Actualiza plugins y herramientas definidas en `mise/config.toml`.
- Uso:
	```bash
	make mise
	make test-mise
	```
#### Herramientas gestionadas:

| Herramienta     | Versión    |
|-----------------|------------|
| java            | 21         |
| node            | 22         |
| python          | 3          |
| rust            | nightly    |
| yarn            | 4          |
| aws-vault       | latest     |
| awscli          | latest     |
| bat             | latest     |
| delta           | latest     |
| fd              | latest     |
| fzf             | latest     |
| gcloud          | latest     |
| github-cli      | latest     |
| go              | latest     |
| jq              | latest     |
| kubectl         | latest     |
| neovim          | latest     |
| pnpm            | 9.7        |
| starship        | latest     |
| terraform       | 1.9        |
| terragrunt      | 0.67       |
| tflint          | 0.53.0     |
| k9s             | latest     |


### nvim (Neovim)
- Instala y configura Neovim.
- Crea enlaces simbólicos para el archivo de configuración (`init.vim`).
- Instala plugins y personalizaciones.
- Uso:
	```bash
	make nvim
	make test-nvim
	```
**Configuración personalizada:**
- Plugins gestionados con Vundle:
  - rust-lang/rust.vim (Rust)
  - airblade/vim-gitgutter (anotaciones Git)
  - preservim/nerdtree (explorador de archivos)
  - vim-airline/vim-airline y vim-airline-themes (barra de estado)
  - nordtheme/vim (tema)
  - tpope/vim-fugitive (integración Git)
  - ctrlpvim/ctrlp.vim (búsqueda de archivos)
  - terryma/vim-expand-region (selección)
  - udalov/kotlin-vim (Kotlin)
  - Yggdroot/indentLine (indentación)
  - ntpeters/vim-better-whitespace (espacios)
  - hashivim/vim-terraform (Terraform)
  - rking/ag.vim (búsqueda ag)
- Numeración de líneas, búsqueda incremental, autocompletado, scrolloff, autoindent.
- Integración y mapeos para NERDTree, Airline, GitGutter, Rust.
- Plugins y temas para desarrollo en varios lenguajes.

### starship
- Instala y configura el prompt [starship](https://starship.rs/).
- Crea la carpeta `.starship` y el symlink para `starship.toml`.
- Personaliza el prompt según el archivo de configuración.
- Uso:
	```bash
	make starship
	make test-starship
	```
- **Formato general:**  
  El archivo de configuracion contiene lo siguiente:

  - **Batería:**  
    - Muestra ⚡️ al cargar y 💀 al descargar.  
    - Cambia de color según el porcentaje (amarillo <20%, rojo <10%).

  - **Símbolo de comando:**  
    - ❯ en éxito (verde), ✗ en error (rojo).

  - **Duración de comandos:**  
    - Muestra el tiempo si el comando tarda más de 1 segundo.

  - **Directorio:**  
    - Trunca rutas largas y muestra si es solo lectura.

  - **Git:**  
    - Muestra rama, commit, estado (adelantado, atrasado, conflictos, divergencias).

  - **Kubernetes:**  
    - Muestra el contexto y alias personalizados para entornos dev, demo, live, etc.

  - **Python:**  
    - Muestra el entorno virtual activo.

  - **Hora:**  
    - Muestra la hora actual en el prompt.

Todos los estilos y símbolos pueden personalizarse editando `starship/starship.toml`.
### terminator
- Instala y configura el emulador de terminal Terminator.
- Crea la carpeta de configuración y copia el archivo `config`.
- Uso:
	```bash
	make terminator
	make test-terminator
	```
**Configuración personalizada:**
- Perfil por defecto con color de texto verde (`#00ff00`).
- Scrollback infinito para historial de terminal.
- Layout y estructura de ventanas/terminales predefinidos.
- Sección de plugins lista para ampliar.
- Keybindings y opciones globales configurables.

### vscode
- Instala y configura Visual Studio Code.
- Crea enlaces simbólicos para el archivo `settings.json`.
- Instala extensiones recomendadas.
- Uso:
	```bash
	make vscode
	make test-vscode
	```
**Configuración personalizada:**
- Formatters y configuración por lenguaje:
  - HTML, JS, JSON, Markdown, Python, Rust, Terraform, TypeScript, Vue, YAML.
  - Formateo automático al guardar para varios lenguajes.
- Ajustes visuales y de accesibilidad:
  - Transparencia, vibrancy, fondo personalizado.
- Integraciones y extensiones:
  - Deno, Supabase, Prettier, ESLint, Volar, Markdown All in One, Rust Analyzer.
- Algoritmo avanzado de diff, sugerencias inteligentes, alias para git, etc.

### zsh
- Instala y configura Zsh.
- Instala Oh My Zsh y plugins.
- Crea enlaces simbólicos para archivos de configuración.
- Uso:
	```bash
	make zsh
	make test-zsh
	```

### obsidian
- Instala el gestor de notas Obsidian.
- (Opcional, solo si está en la lista de dependencias).
- Uso:
	```bash
	make obsidian
	make test-obsidian
	```

### code
- Instala Visual Studio Code (alternativa a `vscode`).
- Uso:
	```bash
	make code
	make test-code
	```

### steam
- Instala Steam (opcional, solo si está en la lista de herramientas secundarias).
- Uso:
	```bash
	make steam
	make test-steam
	```

### discord
- Instala Discord (opcional, solo si está en la lista de herramientas secundarias).
- Uso:
	```bash
	make discord
	make test-discord
	```

## Estructura del proyecto

- `dependencies.sh`: Instala dependencias básicas y opcionales.
- `<herramienta>/install.sh`: Instala y configura cada herramienta.
- `Makefile`: Orquesta la instalación y las pruebas.

## Requisitos

- Sistema basado en Debian/Ubuntu
- Docker (para pruebas automáticas)

## Personalización

Puedes modificar los scripts `install.sh` para adaptar configuraciones, rutas o instalar plugins adicionales.



