#!/bin/bash
function main() {
  sudo systemctl enable postgresql.service 
  sudo systemctl start postgresql.service
  createdb emacsconfig
  psql -d emacsconfig < ~/weiss/EmacsConfigManager/emacsconfig.dmp 
  createdb recentf
  psql -d recentf < ~/clojure/recentf-db/recentf.dmp 
}

main
