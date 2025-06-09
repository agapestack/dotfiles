# Dotfiles

> Personal Arch Linux configuration files and setup automation

## Quick Start

```bash
cd ~
git clone git@github.com:agapestack/dotfiles.git
cd dotfiles
make help        # Show available commands
make install-core # Install essential packages
make link        # Create symlinks for dotfiles
```

## Features

- **Shell**: Zsh with Zim framework and Starship prompt
- **Package Management**: Pacman + Yay (AUR helper)
- **Node.js**: NVM for version management
- **Python**: Anaconda/Conda
- **Rust**: Rustup toolchain
- **Editor**: Neovim as default

## Key Commands

```bash
make install-core  # Install basic tools and packages
make install-kde   # Install KDE desktop environment  
make link          # Create dotfile symlinks with stow
make zsh           # Install zsh and plugins
make starship      # Install starship prompt
```
