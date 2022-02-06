#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias go=go1.18beta1
alias gofmt1.18="go1.18beta1 fmt"
PS1='[\u@\h \W]\$ '
[ -f "/home/weiss/.ghcup/env" ] && source "/home/weiss/.ghcup/env" # ghcup-env
