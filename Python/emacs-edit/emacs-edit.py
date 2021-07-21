import os
import subprocess
import sys
# import pyperclip
import time
from pynput.keyboard import Key, Controller

def get_class_by_name(name):
    cmd = 'sh getwindclassbyname'
    return subprocess.getoutput(
        'bash /home/weiss/weiss/x11-management/getwindclassbyname %s' % name)

if len(sys.argv) < 3:
    active_window = subprocess.getoutput('xdotool getactivewindow')
    active_window_name = subprocess.getoutput(
        'xdotool getactivewindow getwindowname')
    cmd = 'emacsclient -e \'(weiss-edit-with-emacs %s \"%s\")\'' % (
        active_window, active_window_name)
    os.system(cmd)
    time.sleep(0.1)
    os.system('emacsclient -e \'(rime-force-enable)\'')
    time.sleep(0.3)
    os.system('emacsclient -e \'(rime-force-enable)\'')
else:
    wind_id = sys.argv[1]
    wind_name = sys.argv[2]
    wind_class = get_class_by_name(wind_name).lower()
    os.system('xdotool windowactivate %s' % wind_id)
    # k = PyKeyboard()
    # k.press_keys([k.shift_r_key, k.insert_key])
    keyboard = Controller()
    t = time.time()
    if "spotify" in wind_class:
        time.sleep(0.4)
    elif "tim" in wind_class or "wechat" in wind_class:
        time.sleep(0.3)
    else:
        time.sleep(0.1)
    with keyboard.pressed(Key.ctrl):
        keyboard.press('v')
        keyboard.release('v')
