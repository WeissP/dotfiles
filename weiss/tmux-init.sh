#!/bin/bash
tmux new-session -A -d -s Scratch 'OrgTimer';  
tmux set-option -g set-titles-string "tmux-Scratchpad"
tmux new-window -n pdf
tmux send 'watch-pdf' ENTER;
tmux new-window -n aria2
tmux send 'aria2c --input-file=/home/weiss/.config/aria2/downloadsURL.txt --conf-path=/home/weiss/.config/aria2/aria2.conf' ENTER;      
tmux new-window -n xkeysnail
tmux send 'sudo xkeysnail /home/weiss/.config/xkeysnail/config.py --watch' ENTER;
tmux new-window -n hh
tmux send 'hh' ENTER;
tmux new-window
tmux a -t Scratch;            
