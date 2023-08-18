SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

.PHONY: link install-theme install-yay install-asdf install-rust install-zellij install-screenshot install-login install-tools install-fonts install-term etc-env uninstall-src install-file-manager install-powerlevel install-sway install-addons install-pdfutils install-nvim install-latex install-audio install-yubikey

all: help

## GLOBAL MACRO
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

install-theme:	## install terminal theme
	make install-powerlevel

## SYSTEM
install-yay: ## install yay
	pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

install-asdf: ## install asdf
	cd ~
	git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
	cd dotfiles

install-rust: ## install rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

install-zellij: ## install zellij
	cargo install --locked zellij
	rustup update

install-screenshot: ## install slurp & grim for screenshot
	yay -S grim slurp

install-login: ## install ly for login screen
	yay -S ly
	sudo systemctl enable ly

install-tools: ## pkg-config curl git wl-clipboard
	pacman -S pkg-config curl git lua wl-clipboard

install-nvim: ## install neovim
	pacman -S neovim xsel ripgrep

install-term: ## zsh zsh-completions foot tmux
	yay -S zsh foot zsh-completions tmux

install-file-manager: ## install thunar, imv for image, vlc for videos
	pacman -S thunar imv vlc

install-sway: ## swayfx waybar swaylock-effects-git swayidle swaybg wev xorg-xwaylang brightnessctl autotiling mako mpv swayimg
	yay -S swayfx waybar swaylock-effects-git swayidle swaybg mako mpv xorg-xwayland brightnessctl wev autotiling wdisplays-git swayimg

## UTILS
install-yubikey: ## yubikey-manager libfido2
	pacman -S yubikey-manager libfido2 yubikey-touch-detector

install-addons: ## neofetch
	pacman -S neofetch

install-pdfutils: ## zathura zathura-pdf-mupdf
	pacman -S zathura zathura-pdf-mupdf

install-latex: ## texlive-binextra (latexmk) texlive
	pacman -S texlive-binextra texlive

install-audio: ## pipewire helvum pavucontrol
	pacman -S pipewire pipewire-alsa pipewire-pulse helvum pavucontrol

## THEME
install-powerlevel: ## install powerlevel10K
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

install-font: ## adobe-ro font-awesome roboto-mono-nerd
	pacman -S adobe-source-code-pro-fonts otf-font-awesome ttf-font-awesome ttf-roboto-mono-nerd ttf-jetbrains-mono

## UNINSTALL
uninstall-src: ## remove $HOME/dotfiles/src folder
	rm -rf "${HOME}/dotfiles/src"

## OTHERS
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



