#!/bin/bash

# Packages
packages=(
    rsync
    archlinuxcn-keyring
)

function main() {
    sudo pacman -Syyu

    yay -S --noconfirm rsync
    sudo rsync -aArXvIP $MYUSERDIR/.config/system-level-dotfiles/* /

    check
    sudo pacman -Syyu
    install
}

main


