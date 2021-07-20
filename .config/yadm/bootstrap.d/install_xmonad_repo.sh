#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

packages=(
    xorg
    lightdm
    lightdm-gtk-greeter
    xmonad
    xmonad-contrib
    dmenu
    picom
    nitrogen
)

function main() {
    check
    install
}

main
