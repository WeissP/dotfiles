#!/bin/bash
function main() {
    sudo mkdir -p /var/lib/postgres
    sudo chmod 775 /var/lib/postgres
    sudo chown postgres /var/lib/postgres

    sudo -i -u postgres
}
main
