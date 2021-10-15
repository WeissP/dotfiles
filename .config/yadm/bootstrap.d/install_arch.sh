#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

# Packages
packages=(
    # timeshift
    adobe-source-code-pro-fonts
    adobe-source-han-sans-cn-fonts
    adobe-source-han-sans-hk-fonts
    adobe-source-han-sans-jp-fonts
    adobe-source-han-sans-tw-fonts
    adobe-source-han-serif-cn-fonts
    adobe-source-han-serif-hk-fonts
    adobe-source-han-serif-jp-fonts
    adobe-source-han-serif-tw-fonts
    alacritty
    alsa-utils
    android-tools    
    annie
    arandr
    aria2
    autojump
    babashka
    bat
    blueman
    chromium
    clang
    clojure
    clojure-kondo-bin
    cmake
    cronie
    docker
    dua-cli
    exa
    fd
    feh
    flameshot
    fzf
    git
    go
    google-chrome
    gperf
    gpick
    hunspell
    hunspell-de
    hunspell-en_us
    libappindicator-gtk3
    mplayer
    neofetch                    # screenfetch
    nerd-fonts-fira-code
    nerd-fonts-mononoki
    network-manager-applet
    networkmanager-iwd
    npm
    oft-symbola
    openconnect
    openssh
    p7zip
    pass
    pavucontrol
    php
    postgresql
    powerline-fonts
    pulseaudio
    python-pip
    qimgv
    redshift-gtk-git
    ripgrep
    ripgrep-all
    rsnapshot
    rsync
    scrcpy
    sdcv
    spotify
    symbola
    syncthing
    texlive-langchinese
    texlive-most
    thunderbird
    trayer-srg
    ttf-jetbrains-mono
    udisk2
    unclutter-xfixes-git
    unzip
    update-grub
    wqy-bitmapfont
    wqy-microhei
    wqy-microhei-lite
    wqy-zenhei
    xautomation
    xbindkeys
    xdotool
    xournal
    youtube-dl
    zsh
)

function main() {
    check

    install

    sudo systemctl start sshd
    # sudo systemctl enable --now networkmanager
    sudo systemctl enable --now cronie
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"

    chsh -s $(which zsh)
    cat $MYUSERDIR/weiss/crontab-jobs | crontab -

    cd $MYUSERDIR/
    git clone git@github.com:WeissP/.password-store.git

    mkdir -p $MYUSERDIR/clojure
    cd $MYUSERDIR/clojure
    git clone git@github.com:WeissP/hledger-helper.git

    mkdir -p $MYUSERDIR/go/src
    cd $MYUSERDIR/go/src
    git clone git@github.com:WeissP/OrgTimer.git
}

main


