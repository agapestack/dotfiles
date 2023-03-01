SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

all: help

## GLOBAL
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/'

etc-env: ## overwrite environment file with etc/environment
	cat etc/environment > /etc/environment

install-theme:	## install terminal theme
	make install-gogh
	make install-powerlevel

allow-scripts: ## give execution rights to scripts
	sudo chmod +x ${HOME}/dotfiles/scripts/*.sh

## THEME
install-gogh: ## install gogh
	/bin/bash ${HOME}/dotfiles/scripts/gogh.sh

install-powerlevel: ## install powerlevel10K
	cd ~
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	cd dotfiles

install-arch: ## install usefull arch deps
	sudo pacman -S sway wofi waybar zsh dmenu otf-font-awesome mdp alacritty adobe-source-code-pro-fonts

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

.PHONY: link install-theme allow-scripts install-gogh install-powerlevel install-arch uninstall-src help etc-env


