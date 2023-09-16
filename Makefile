SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

USERNAME="agape"

.PHONY: link install-theme install-yay install-asdf install-rust install-screenshot install-login install-tools install-fonts install-term etc-env uninstall-src install-file-manager install-powerlevel install-sway install-addons install-pdfutils install-nvim install-latex install-audio install-yubikey install-utils install-bluetooth install-dark

all: help

## GLOBAL MACRO
link: ## run stow to create symlinks
	cd ~
	stow -d ~/dotfiles -t ~ --dotfiles . --ignore='^README.*' --ignore='Makefile' --ignore='etc/' --ignore='img/'

install-theme:	## install terminal theme
	make install-powerlevel

## SYSTEM
install-yay: ## install yay
	sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

install-asdf: ## install asdf
	cd ~
	git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si
	cd dotfiles

install-rust: ## install rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

install-screenshot: ## install slurp & grim for screenshot
	yay -S grim slurp

install-login: ## install login manager: ly
	sudo pacman -S ly
	sudo systemctl enable ly

install-tools: ## pkg-config curl git wl-clipboard
	sudo pacman -S pkg-config curl git lua wl-clipboard

install-nvim: ## install neovim
	sudo pacman -S neovim xsel ripgrep

install-term: ## zsh zsh-completions alacritty tmux
	yay -S zsh alacritty zsh-completions tmux

install-file-manager: ## install imv for image, vlc for videos
	sudo pacman -S imv vlc swayimg pcmanfm-gtk3

install-sway: ## swayfx waybar swaylock-effects swayidle swaybg wev xorg-xwaylang brightnessctl autotiling mako mpv swayimg wofi
	yay -S swayfx waybar swaylock-effects swayidle swaybg mako mpv xorg-xwayland brightnessctl wev autotiling wdisplays-git wofi

## UTILS
install-utils: ## firefox
	sudo pacman -S firefox

install-dark: ## gnome-themes-extra adwaita-qt5 adwaita-qt6
	yay -S gnome-themes-extra adwaita-qt5 adwaita-qt6

install-bluetooth: ## bluez bluez-utils blueman
	sudo pacman -S bluez bluez-utils blueman
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service

install-yubikey: ## yubikey-manager libfido2
	sudo pacman -S yubikey-manager libfido2

install-addons: ## neofetch
	sudo pacman -S neofetch

install-pdfutils: ## zathura zathura-pdf-mupdf
	sudo pacman -S zathura zathura-pdf-mupdf

install-latex: ## texlive-binextra (latexmk) texlive
	sudo pacman -S texlive-binextra texlive

install-audio: ## pipewire helvum pavucontrol wireplumber
	sudo pacman -S pipewire pipewire-alsa pipewire-pulse helvum pavucontrol wireplumber

## THEME
install-powerlevel: ## install powerlevel10K
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

install-font: ## shit-ton of fonts
	sudo pacman -S adobe-source-code-pro-fonts otf-font-awesome ttf-font-awesome ttf-roboto-mono-nerd ttf-jetbrains-mono ttf-liberation ttf-droid nerd-fonts

## UNINSTALL
uninstall-src: ## remove $HOME/dotfiles/src folder
	rm -rf "${HOME}/dotfiles/src"

## OTHERS
etc-env: ## overwrite corresponding files in /etc by ./etc
	cp -r -f /home/${USERNAME}/dotfiles/etc/** /etc
	sudo chmod +x /etc/lemurs/wayland/sway

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
