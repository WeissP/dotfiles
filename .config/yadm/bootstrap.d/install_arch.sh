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
    fd
    fzf
    ripgrep
    rsync
    alacritty
    cronie
    thunderbird
    chromium

    clang
    cmake
    gperf
    php

    unclutter
    openconnect
    aria2
    npm
    python-pip
    starship-bin
    openssh

    clojure
    babashka

    # Fonts
    adobe-source-code-pro-fonts
    powerline-fonts
    wqy-bitmapfont
    wqy-microhei
    wqy-microhei-lite
    wqy-zenhei
    ttf-jetbrains-mono
    nerd-fonts-fira-code

    hunspell
    hunspell-de
    hunspell-en_us

    postgresql
    rsnapshot
    youtube-dl
    annie
    docker
    fcitx-rime
    xournal
    mplayer
)

function main() {
    check

    install

    sudo systemctl start sshd
    chsh -s $(which zsh)
    cat $MYUSERDIR/weiss/crontab-jobs | crontab -
}

main
