#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
[ -f "/home/weiss/.ghcup/env" ] && source "/home/weiss/.ghcup/env" # ghcup-env
