#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

# Packages
packages=(
    git
    autojump
    zsh
    neofetch                    # screenfetch
    bat
    p7zip
    fd
    fzf
    ripgrep
    ripgrep-all
    rsync
    alacritty
    cronie
    thunderbird
    # chromium
    sdcv

    clang
    cmake
    gperf
    php

    unclutter-xfixes-git
    openconnect
    aria2
    npm
    python-pip
    starship-bin
    openssh

    clojure
    babashka
    clojure-kondo-bin

    # Fonts
    oft-symbola
    adobe-source-code-pro-fonts
    powerline-fonts
    wqy-bitmapfont
    wqy-microhei
    wqy-microhei-lite
    wqy-zenhei
    ttf-jetbrains-mono
    nerd-fonts-fira-code
    nerd-fonts-mononoki

    hunspell
    hunspell-de
    hunspell-en_us

    postgresql
    rsnapshot
    timeshift
    youtube-dl
    annie
    docker
    xournal
    mplayer
    xautomation
    xbindkeys

    pulseaudio
    pavucontrol
    alsa-utils
    libappindicator-gtk3
    blueman
    networkmanager-iwd
    network-manager-applet
    trayer-srg
    gpick
    feh
    qimgv

    update-grub
    hibernator

    texlive-most
    texlive-langchinese
)

function main() {
    check

    install

    sudo systemctl start sshd
    # sudo systemctl enable --now networkmanager
    sudo systemctl enable --now cronie
    chsh -s $(which zsh)
    cat $MYUSERDIR/weiss/crontab-jobs | crontab -
}

main
