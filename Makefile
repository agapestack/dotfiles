SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
WHITE  := $(shell tput setaf 7)
CYAN   := $(shell tput setaf 6)
RESET  := $(shell tput sgr0)

.PHONY: all link install-core install-kde install-konsave uninstall-src basic asdf typescript yay zsh tldr spotify media audio rust help

all: help

## GLOBAL
link: ## run stow to create symlinks
	@cd ~ && \
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

install-core: basic yay zsh rust ## Install essential packages: basic, yay, zsh, rust

install-kde: ## Install KDE desktop environment and utilities
	sudo pacman -S --noconfirm plasma-desktop kdeplasma-addons sddm{,-kcm} dolphin bluedevil kscreen spectacle

install-konsave: ## Install konsave to backup KDE settings
	python -m pip install --user konsave

uninstall-src: ## Remove the src folder from dotfiles
	@rm -rf "${HOME}/dotfiles/src" && echo "src folder removed."

## INSTALL
basic: ## Install basic packages: pkg-config, curl, git, etc.
	sudo pacman -S --noconfirm pkg-config curl git lua neofetch vim kitty

asdf: ## Install asdf, direnv, nodejs
	git clone https://aur.archlinux.org/asdf-vm.git ${HOME}/asdf-vm && \
	(cd ${HOME}/asdf-vm && makepkg -si --noconfirm) && \
	asdf plugin-add direnv && asdf direnv setup --shell bash --version latest && \
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

typescript: yay ## Install TypeScript
	yay -S --noconfirm typescript

yay: ## Install yay (AUR helper)
	sudo pacman -S --needed --noconfirm git base-devel && \
	git clone https://aur.archlinux.org/yay.git && \
	cd yay && makepkg -si --noconfirm

zsh: yay ## Install zsh, tmux, p10k, and plugins
	yay -S --noconfirm zsh zsh-completions tmux zsh-syntax-highlighting-git && \
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k

tldr: ## Install tldr
	yay -S --noconfirm tldr

spotify: ## Install Spotify
	yay -S --noconfirm spotify

audio: ## Install audio packages
	yay -S --noconfirm plasma-pa pulseaudio pulseaudio-alsa pulseaudio-bluetooth

media: ## Install media packages: VLC, Gwenview
	sudo pacman -S --noconfirm vlc gwenview

rust: basic ## Install Rustup for Rust development
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## HELP
help: ## Show this help message.
	@echo ''
	@echo 'Usage:'
	@echo '  $(YELLOW)make$(RESET) $(GREEN)<target>$(RESET)'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    $(YELLOW)%-30s$(GREEN)%s$(RESET)\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  $(CYAN)%s$(RESET)\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)

