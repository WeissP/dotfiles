#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

# Packages
packages=(
    rsync
    archlinuxcn-keyring
)

function main() {
    sudo pacman -Syyu

    yay -S --noconfirm rsync fcitx-rime
    sudo rsync -aArXvIP $MYUSERDIR/.config/system-level-dotfiles/* /

    check
    sudo pacman -Syyu
    install
}

main


