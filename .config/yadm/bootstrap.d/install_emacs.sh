#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

function main() {
    echo "start clone"
    cd $MYUSERDIR
    git clone https://git.savannah.gnu.org/git/emacs.git
    cd emacs
    git checkout 00101a8d4cc5bbf875711753c936be52e6e549b1
    ./configure --with-gnutls --with-imagemagick --with-jpeg --with-png --with-rsvg --with-tiff --with-wide-int --with-xft --with-xml2 --with-xpm prefix=/usr/local
    make -j4
    sudo make install

    mkdir -p $MYUSERDIR/weiss
    cd $MYUSERDIR/weiss
    git clone git@github.com:WeissP/EmacsConfigManager.git
    cd EmacsConfigManager
    go get
    
    mkdir -p $MYUSERDIR/clojure
    cd $MYUSERDIR/clojure
    git clone git@github.com:WeissP/recentf-db.git

    cd $MYUSERDIR
    git clone git@github.com:WeissP/.emacs.d.git

    cd $MYUSERDIR/weiss
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags
    ./autogen.sh
    ./configure
    make
    sudo make install

    cd $MYUSERDIR/weiss
    git clone https://github.com/tdlib/td.git
    cd td
    rm -rf build
    mkdir build
    cd build
    cmake ../
    make -j4
    sudo make install
}

main
