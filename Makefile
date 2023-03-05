SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

all: help

## GLOBAL MACRO
.PHONY: link
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

.PHONY: install-theme
install-theme:	## install terminal theme
	make install-powerlevel

.PHONY: allow-scripts
allow-scripts: ## give execution rights to scripts
	sudo chmod +x ${HOME}/dotfiles/scripts/*.sh

## SYSTEM
.PHONY: install-yay
install-yay: ## install yay
	pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

.PHONY: install-asdf
install-asdf: ## install asdf
	cd ~
	git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
	cd dotfiles

.PHONY: install-rust
install-rust: ## install rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

.PHONY: install-zellij
install-zellij: ## install zellij
	cargo install --locked zellij
	rustup update

.PHONY: install-login
install-login: ## install ly for login screen
	yay -S ly
	sudo systemctl enable ly

.PHONY: install-tools
install-tools: ## pkg-config curl git
	pacman -S pkg-config curl git lua

.PHONY: install-term
install-term: ## zsh alacritty
	yay -S zsh alacritty

.PHONY: install-file-manager
install-file-manager: ## thunar
	pacman -S thunar

.PHONY: install-sway
install-sway: ## sway waybar swaylock-effects-git swayidle swaybg
	yay -S sway waybar swaylock-effects-git swayidle swaybg mako xorg-xwayland

.PHONY: install-addons
install-addons:
	pacman -S neofetch mpd rofi


.PHONY: install-font
install-font: ## adobe-ro font-awesome roboto-mono-nerd
	pacman -S adobe-source-code-pro-fonts otf-font-awesome ttf-font-awesome ttf-roboto-mono-nerd

## THEME
.PHONY: install-powerlevel
install-powerlevel: ## install powerlevel10K
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

## UNINSTALL
.PHONY: uninstall-src
uninstall-src: ## remove $HOME/dotfiles/src folder
	rm -rf "${HOME}/dotfiles/src"

## OTHERS
.PHONY: etc-env
etc-env: ## overwrite environment file with etc/environment
	cat etc/environment > /etc/environment

## HELP
help: ## Show this help.
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    ${YELLOW}%-30s${GREEN}%s${RESET}\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  ${CYAN}%s${RESET}\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)


