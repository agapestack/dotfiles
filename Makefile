SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

.PHONY: link install-core install-kde uninstall-src basic asdf typescript yay zsh tldr spotify media audio rust help

all: help

## GLOBAL
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

install-core: basic yay zsh rust ## basic yay zsh rust

install-kde: ## plasma-desktop kdeplasma-addons sddm sddm-kcm dolphin bluedevil kscreen spectacle
	sudo pacman -S plasma-desktop kdeplasma-addons sddm{,-kcm} dolphin bluedevil kscreen spectacle

uninstall-src: ## remove $HOME/dotfiles/src folder
	rm -rf "${HOME}/dotfiles/src"
	
## INSTALL
basic: ## pkg-config curl git lua neofetch vim kitty
	sudo pacman -S pkg-config curl git lua neo{fetch,vim} kitty starship

asdf: ## asdf direnv nodejs
	git clone https://aur.archlinux.org/asdf-vm.git ${HOME} && (cd ${HOME}/asdf-vm && makepkg -si)
	asdf plugin-add direnv
	asdf direnv setup --shell bash --version latest
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

typescript: yay ## typescript
	yay -S typescript

yay: ## yay
	sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

zsh: yay ## zsh zsh-completions tmux zsh-syntax-highlighting-git prezto starship
	yay -S zsh zsh-completions tmux zsh-syntax-highlighting-git
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
	curl -sS https://starship.rs/install.sh | sh


tldr: ## tldr
	yay -S tldr

spotify: ## spotify
	yay -S spotify

audio: ## plasma-pa pulseaudio pulseaudio-alsa pulseaudio-bluetooth
	yay -S plasma-pa pulseaudio pulseaudio-alsa pulseaudio-bluetooth

media: ## vlc gwenview
	sudo pacman -S vlc gwenview

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
