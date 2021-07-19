#!/bin/bash

user_dir="/home/weiss"

function main() {
    echo "start clone"
    cd $user_dir
    git clone https://git.savannah.gnu.org/git/emacs.git
    cd emacs
    git checkout 00101a8d4cc5bbf875711753c936be52e6e549b1
    ./configure --with-gnutls --with-imagemagick --with-jpeg --with-png --with-rsvg --with-tiff --with-wide-int --with-xft --with-xml2 --with-xpm prefix=/usr/local
    make -j4
    make install

    mkdir -p ~/weiss
    cd ~/weiss
    git clone git@github.com:WeissP/EmacsConfigManager.git
    cd EmacsConfigManager
    go get
    
    git clone git@github.com:WeissP/recentf-db.git

    cd ~
    git clone git@github.com:WeissP/.emacs.d.git
}

main