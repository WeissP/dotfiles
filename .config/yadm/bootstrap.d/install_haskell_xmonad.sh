#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 


packages=(
    xorg
    libx11
    libxft
    libxext
    libxinerama
    libxrandr
    libxss
    lightdm
    lightdm-gtk-greeter
    dmenu
    picom
    nitrogen
)

function main() {
    check

    install

    export BOOTSTRAP_HASKELL_INSTALL_STACK=true
    export BOOTSTRAP_HASKELL_INSTALL_HLS=true
    export BOOTSTRAP_HASKELL_ADJUST_BASHRC=true
    export BOOTSTRAP_HASKELL_NONINTERACTIVE=true    
    export TMPDIR=$MYUSERDIR/tmp

    mkdir -p /home/weiss/tmp
    cd /home/weiss/tmp
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    source /home/weiss/.ghcup/env
    export PATH=/home/weiss/.local/bin:$PATH

    cabal install stack
    stack install xmonad
    stack install xmonad-contrib
    stack install xmobar
    stack install ormolu
    
    sudo systemctl enable lightdm
}

main
