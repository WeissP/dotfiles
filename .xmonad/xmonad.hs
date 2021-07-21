import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

myTerminal = "alacritty"

myModMask = mod4Mask

myKeys =
  [ ("C-r", spawn "dmenu_run"),
    ("<F6>", spawn myTerminal),
    ("M-1", windows W.focusUp),
    ("M-2", windows W.focusDown)
  ]

main :: IO ()
main =
  xmonad $
    def
      { modMask = myModMask,
        terminal = myTerminal
      }
      `additionalKeysP` myKeys
