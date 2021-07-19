#!/bin/bash
#############################################################
# Install packages for Archlinux or its derived editions (e.g. Manjaro).
# Author: Vincent Zhang <seagle0128@gmail.com>
# URL: https://github.com/seagle0128/dotfiles
#############################################################
# Packages
packages=(
    git
    autojump
    zsh
    # emacs
    neofetch                    # screenfetch
    bat
    fd
    fzf
    ripgrep
    rsync
    # shadowsocks-qt5

    npm
    python-pip
    starship-bin
    openssh
    clojure
    # Fonts
    adobe-source-code-pro-fonts
    powerline-fonts
    wqy-bitmapfont
    wqy-microhei
    wqy-microhei-lite
    wqy-zenhei
    ttf-jetbrains-mono
)

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if command -v tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

function check() {
    if ! command -v yay >/dev/null 2>&1 && ! command -v pacman >/dev/null 2>&1; then
        echo "${RED}Error: not Archlinux or its devrived edition.${NORMAL}" >&2
        exit 1
    fi
}

function install() {
    CMD=''
    if command -v yay >/dev/null 2>&1; then
        CMD='yay -S --noconfirm'
    elif command -v pacman >/dev/null 2>&1; then
        CMD='sudo pacman -S --noconfirm'
    else
        echo "${RED}Error: not Archlinux or its devrived edition.${NORMAL}" >&2
        exit 1
    fi

    for p in ${packages[@]}; do
        printf "\n${BLUE}➜ Installing ${p}...${NORMAL}\n"
        ${CMD} ${p}
    done
}

function main() {
    check

    if ! command -v yay >/dev/null 2>&1; then
        echo "installing yay"
        pacman -S --needed git base-devel
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
    fi

    install


    sudo systemctl start sshd

}

main
