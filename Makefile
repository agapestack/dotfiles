SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

.PHONY: link install-core install-kde uninstall-src basic asdf yay zsh rust help

all: help

## GLOBAL
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

install-core: basic yay zsh rust ## basic yay zsh rust

install-kde: ## plasma-desktop sddm sddm-kcm konsole
	sudo pacman -S plasma-desktop sddm{,-kcm} konsole

uninstall-src: ## remove $HOME/dotfiles/src folder
	rm -rf "${HOME}/dotfiles/src"
	
## INSTALL
basic: ## pkg-config curl git lua neofetch vim
	sudo pacman -S pkg-config curl git lua neo{fetch,vim}

asdf: ## asdf
	git clone https://aur.archlinux.org/asdf-vm.git ${HOME} && (cd ${HOME}/asdf-vm && makepkg -si)

yay: ## yay
	sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

zsh: yay ## zsh zsh-completions tmux zsh-syntax-highlighting-git prezto
	yay -S zsh zsh-completions tmux zsh-syntax-highlighting-git
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

tldr: ## tldr
	yay -S tldr

rust: basic ## install rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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
