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
    xorg-xinit
    rofi
    dmenu
    picom
    nitrogen
)

function main() {
    check

    install

    # install stack
    curl -sSL https://get.haskellstack.org/ | sh

    # install cabal with ghcup
    export BOOTSTRAP_HASKELL_INSTALL_STACK=false
    export BOOTSTRAP_HASKELL_INSTALL_HLS=true
    export BOOTSTRAP_HASKELL_ADJUST_BASHRC=true
    export BOOTSTRAP_HASKELL_NONINTERACTIVE=true    
    export TMPDIR=$MYUSERDIR/tmp

    mkdir -p $MYUSERDIR/tmp
    cd $MYUSERDIR/tmp
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    source $MYUSERDIR/.ghcup/env
    export PATH=$MYUSERDIR/.local/bin:$PATH

    cabal install xmonad
    cabal install --lib xmonad, xmonad-contrib
    cabal install -fall_extensions xmobar

    rm -rf $MYUSERDIR/.xmonad
    cd $MYUSERDIR/.config
    git clone --recurse-submodules git@github.com:WeissP/xmonad-project.git    

    cabal update
    cabal install alex happy
    cabal install hledger-1.23 hledger-ui-1.23 hledger-web-1.23

}

main
