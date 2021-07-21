import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

-- layout with mouse
-- import XMonad.Actions.MouseResize

myTerminal = "alacritty"

myModMask = mod4Mask

myKeys =
  [ ("C-r", spawn "dmenu_run"),
    ("<F6>", spawn myTerminal),
    ("<F15>", windows W.swapMaster),
    ("M-<Escape>", kill),
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
