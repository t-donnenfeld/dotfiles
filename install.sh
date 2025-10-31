#!/bin/bash

sudo pacman -Syu
sudo pacman -S git unzip ttf-jetbrains-mono-nerd vim bash

chsh -s /bin/bash

git clone --depth=1 https://github.com/catppuccin/kde /tmp/catppuccin-kde  && cd /tmp/catppuccin-kde && ./install.sh
