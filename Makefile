SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

USERNAME="agape"

.PHONY: link install-theme install-yay install-asdf install-rust install-tools install-fonts install-term uninstall-src install-powerlevel install-addons install-yubikey install-utils

all: help

## GLOBAL MACRO
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

install-theme:	## install terminal theme
	make install-powerlevel
	make install-zsh-plugins

## SYSTEM
install-yay: ## install yay
	sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

install-asdf: ## install asdf
	cd ~
	git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
	cd dotfiles

install-rust: ## install rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

install-tools: install-rust ## pkg-config curl git lua wl-clipboard neovim xsel ripgrep
	sudo pacman -S pkg-config curl git lua wl-clipboard neovim xsel ripgrep
	cargo install stylua

install-term: ## zsh zsh-completions alacritty tmux
	yay -S zsh zsh-completions tmux

## UTILS
install-utils: ## firefox
	sudo pacman -S firefox

install-yubikey: ## yubikey-manager libfido2
	sudo pacman -S yubikey-manager libfido2

install-addons: ## neofetch
	sudo pacman -S neofetch

## THEME
install-powerlevel: ## install powerlevel10K
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

## ZSH plugins
install-zsh-plugins: ## install zsh plugins : zsh-syntax-highlighting, 
	yay -S zsh-syntax-highlighting-git
	sudo echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc


install-font: ## shit-ton of fonts
	sudo pacman -S adobe-source-code-pro-fonts otf-font-awesome ttf-font-awesome ttf-roboto-mono-nerd ttf-jetbrains-mono ttf-liberation ttf-droid nerd-fonts

## UNINSTALL
uninstall-src: ## remove $HOME/dotfiles/src folder
	rm -rf "${HOME}/dotfiles/src"

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
