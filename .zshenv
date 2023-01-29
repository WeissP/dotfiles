# ZSH envioronment
export LANG="en_US.UTF-8"
export TERM=xterm-256color
export DEFAULT_USER=$USER
export VISUAL="emacsclient -c"
export EDITOR="$VISUAL"
export PATH=$HOME/weiss/:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH

# texlive
export PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH

# java
export PATH=/usr/lib/jvm/java-11-openjdk/bin/:$PATH

# Haskell
export PATH=HOME/.cabal/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.ghcup/bin/:$PATH
# export XMONAD_CONFIG_DIR=$HOME/.config/xmonad-project
# export XMONAD_DATA_DIR=$HOME/.config/xmonad-project

# Golang
export GO111MODULE=auto
export GOPROXY=https://goproxy.cn # https://athens.azurefd.net
export GOPATH=$HOME/go
# export GOROOT=$HOME/go/bin/
# export GOROOT=
export PATH=${GOPATH//://bin:}/bin:$PATH

# QMK
export QMK_HOME=$HOME/weiss/qmk_firmware

# ROS
export ROS_TAG="melodic"
export KARAT_ROS_TAG="melodic"

# hledger
export LEDGER_FILE=$HOME/finance/2021.journal

# Rust
export PATH=/home/weiss/.cargo/bin:$PATH

# digivne
export DIGIVINE_ROOT_PATH="/home/weiss/weiss/digiVine/"
export DIGIVINE_DB_TEST_URL="postgres://weiss@localhost/digivine"
export POSTGIS_DIESEL_DATABASE_URL="postgres://weiss@localhost/digivine"
