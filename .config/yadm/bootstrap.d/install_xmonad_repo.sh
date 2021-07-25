#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

packages=(
    xorg
    xorg-xmessage
    xterm
    lightdm
    lightdm-gtk-greeter
    xmonad
    xmonad-contrib
    xmobar
    dmenu
    picom
    nitrogen
)

function main() {
    check
    install
    sudo systemctl enable lightdm
}

main
