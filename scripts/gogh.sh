#!/bin/bash
set -eu

# bash -c  "$(wget -qO- https://git.io/vQgMr)"
mkdir -p "$HOME/dotfiles/src"
cd "$HOME/dotfiles/src"
git clone https://github.com/Gogh-Co/Gogh.git gogh
cd gogh

export TERMINAL=gnome-terminal

pwd
./themes/argonaut.sh
