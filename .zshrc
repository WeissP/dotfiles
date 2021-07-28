[[ $TERM == "tramp" ]] && unsetopt zle && PS1='$ ' && return

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit for \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \
      OMZL::theme-and-appearance.zsh 

zinit wait lucid for \
      OMZP::colored-man-pages \
      OMZP::extract \
      OMZP::autojump \
      OMZP::git \
      OMZP::sudo

zinit wait lucid for \
      zsh-users/zsh-history-substring-search \
      zsh-users/zsh-autosuggestions \
      hlissner/zsh-autopair

# Completion enhancements
zinit ice wait lucid atload"zicompinit; zicdreplay" blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit"zicompinit; zicdreplay"
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid from'gh-r' as'program'
zinit light sei40kr/fast-alias-tips-bin
zinit ice wait lucid depth"1"
zinit light sei40kr/zsh-fast-alias-tips

gen-tags() {
    read ctagslang'?langs:'
    ctags --languages=$ctagslang --kinds-all='*' --fields='*' --extras='*' -R
}

# autojump
[[ -f ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

alias ra="ranger"
alias pii="sudo pip install"
alias py="python"
alias fdr="cd / && sudo fd "
alias dt="dotnet test"
alias wl="cd ~/Downloads && wget -c --no-check-certificate --limit-rate=1300k"
alias wnl="cd ~/Downloads && wget -c --no-check-certificate"
alias ec="emacsclient --create-frame --alternate-editor=\"\""
alias ed="emacs --dump-file='/home/weiss/.emacs.d/emacs.pdmp' &"
alias emdbg="emacs --debug-init &"
alias edmake="emacs --batch -q -l ~/.emacs.d/dump.el"
alias ydl='read link && cd ~/Downloads && youtube-dl -r 1500k $link'
alias ydla='read link && cd ~/Downloads && youtube-dl -x $link' #only audio
alias pyav="python /home/weiss/Python/getAvInfo.py"
alias yays="yay -S "
alias vpnon="sudo systemctl start tukVpn.service"
alias vpnoff="sudo systemctl stop tukVpn.service"
alias lsg="exa --long --git"
alias dmpbk="pg_dump quizzes > /home/weiss/KaRat/datenbank/quizzes.dmp"
alias dmpl="psql -d quizzes < home/weiss/KaRat/datenbank/quizzes.dmp"
alias dc="docker container "
alias control="cd /home/weiss/KaRat/Docker/karat-ros-docker/ &&  sh run_karat_control.sh"
alias qmkc="cd /home/weiss/qmk_firmware/keyboards && qmk compile -kb handwired/dactyl_manuform/6x6 -km weiss"
alias qmkf="cd /home/weiss/qmk_firmware/keyboards && qmk flash -kb handwired/dactyl_manuform/6x6 -km weiss"
alias ka="killall -9 "
alias scp="scrcpy -S &"
alias setup="/home/weiss/weiss/setup.sh"
alias hibernate="sudo systemctl hibernate"

setxkbmap de
mouse.sh

eval "$(starship init zsh)"
