#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
source ./common.sh 

# Packages
packages=(
    clojure
    babashka
    clojure-kondo-bin
)

function main() {
    check
    install
}

main
