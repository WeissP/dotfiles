#!/bin/bash

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

    hunspell
    hunspell-de
    hunspell-en_us

    postgresql
)

function main() {
    check

    install

    sudo systemctl start sshd
    chsh -s $(which zsh)
    cat /home/weiss/weiss/crontab-jobs | crontab -
}

main
