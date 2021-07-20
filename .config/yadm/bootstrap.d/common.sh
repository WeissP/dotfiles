#!/bin/bash

MYUSERDIR="/home/weiss"

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
    CMD='yay -S --noconfirm'

    for p in ${packages[@]}; do
        printf "\n${BLUE}➜ Installing ${p}...${NORMAL}\n"
        ${CMD} ${p}
    done
}

