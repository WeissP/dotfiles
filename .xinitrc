#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

twm &
xclock -geometry 50x50-1+1 &

setxkbmap de &
xset r rate 230 30 & 
xset -dpms &

export GTK_IM_MODULE=fcitx 
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

sh /home/weiss/.screenlayout/vertical.sh &

trayer --monitor 0 --edge top --distancefrom top --SetDockType false --SetPartialStrut false --expand true --width 20 --align right --transparent true --alpha 0 --tint 0x2e3440 --height 24&

# xmobar -x 1 /home/weiss/.config/xmobar/xmobarrc1.hs &

fcitx &

# sudo modprobe bluetooth &
blueman-applet &

if [ -x /usr/bin/nm-applet ] ; then
    nm-applet --sm-disable &
fi

# adb connect 192.168.8.121:5555 &
# # scrcpy -S &

feh --bg-fill --no-fehbg "/home/weiss/Pictures/background/bricks-459299_1920.jpg" &

unclutter --exclude-root --ignore-scrolling&
xbindkeys &

thunderbird &
spotify &
emacs --dump-file='/home/weiss/.emacs.d/emacs.pdmp' &
chromium &
google-chrome-stable &

Mouse_ID=$(xinput list | grep "ELECOM ELECOM TrackBall Mouse" | head -n 1 | sed -r 's/.*id=([0-9]+).*/\1/') &
xinput set-prop ${Mouse_ID} 'libinput Button Scrolling Button' 9 &
xinput set-prop ${Mouse_ID} "libinput Scroll Method Enabled" 0 0 1 &

syncthing &
flameshot &

# for scrcpy
# adb tcpip 5555

mouse.sh &
exec xmonad 
