-- import Graphics.X11.Xlib.Extras
-- import Graphics.X11.Xlib.Event

import Data.Function
import Data.List
import qualified Data.Map as M
import Graphics.X11.Xinerama
import Graphics.X11.Xlib
import System.Exit
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.Submap
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Circle
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Ssh
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import qualified XMonad.StackSet as W
import XMonad.Util.Scratchpad

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "alarcitty"

-- Width of the window border in pixels.
--
myBorderWidth = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
-- myWorkspaces    = ["emacs","lunatique","www", "terminals"] ++ map show [5..10] ++ ["wifi", "music", "SP"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor = "#222222"

myFocusedBorderColor = "#aa0000"

-- myXPConfig = defaultXPConfig

-- sendKeyPress :: KeyMask -> KeySym -> X ()
-- sendKeyPress = userCode $ withDisplay sendKeyPress'
--
-- sendKeyPress' :: Display -> KeyMask -> KeySym -> X ()
-- sendKeyPress' dpy mask key = do
--   root <- asks theRoot
--   time <- currentTime
--   evt  <-

myKeys conf@(XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    -- launch a terminal
    [ ((0, F6), spawn $ XMonad.terminal conf),
      ((0, F17), spawn "dmenu_run")
      --     , ((modMask,               xK_p     )       , spawn "mpc toggle")
      --     , ((modMask,               xK_bracketright) , spawn "mpc volume +5")
      --     , ((modMask,               xK_bracketleft)  , spawn "mpc volume -5")
      --     , ((modMask .|. shiftMask, xK_l)            , spawn "gnome-screensaver-command --lock")

      --     , ((modMask              , xK_x)            , spawn "xmodmap ~/.Xmodmap")

      --     -- close focused window
      --     , ((modMask .|. shiftMask, xK_c     ), kill)

      --      -- Rotate through the available layout algorithms
      --     , ((modMask,               xK_space ), sendMessage NextLayout)

      --     --  Reset the layouts on the current workspace to default
      --     , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

      --     -- Resize viewed windows to the correct size
      --     , ((modMask,               xK_n     ), refresh)

      --     -- Move focus to the next window
      --     , ((modMask,               xK_Tab   ), windows W.focusDown)

      --     -- Move focus to the next window
      --     , ((modMask,               xK_j     ), windows W.focusDown)

      --     -- Move focus to the previous window
      --     , ((modMask,               xK_k     ), windows W.focusUp  )

      --     -- Move focus to the master window
      --     , ((modMask,               xK_m     ), windows W.focusMaster  )

      --     -- Swap the focused window and the master window
      --     , ((modMask,               xK_Return), windows W.swapMaster)

      --     -- Swap the focused window with the next window
      --     , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

      --     -- Swap the focused window with the previous window
      --     , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

      --     -- Shrink the master area
      --     , ((modMask,               xK_h     ), sendMessage Shrink)

      --     -- Expand the master area
      --     , ((modMask,               xK_l     ), sendMessage Expand)

      --     -- Push window back into tiling
      --     , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

      --     -- Increment the number of windows in the master area
      --     , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

      --     -- Deincrement the number of windows in the master area
      --     , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

      --     -- toggle the status bar gap
      --     , ((modMask              , xK_b     ), sendMessage ToggleStruts)

      --     -- Restart xmonad
      --     , ((modMask .|. shiftMask, xK_r     ),
      --        broadcastMessage ReleaseResources >> restart "xmonad" True)

      --     , ((modMask              , xK_g     ),
      --        workspacePrompt  myXPConfig (windows . W.greedyView))
      --     , ((modMask .|. shiftMask, xK_g     ),
      --        workspacePrompt  myXPConfig (windows . W.shift))

      --     -- C-t submap
      --     , ((controlMask, xK_t)       , submap . M.fromList $
      --        [ ((controlMask,  xK_t)      ,   toggleWS)
      --        , ((0,            xK_Tab)    ,   windows W.focusDown) -- @@ Move focus to the next window
      --        , ((shiftMask,    xK_Tab)    ,   windows W.focusUp  ) -- @@ Move focus to the previous window
      --        , ((0,            xK_c)      ,   spawn $ XMonad.terminal conf)
      --        , ((0,            xK_k)      ,   kill)
      --        , ((0,            xK_Return) ,   windows W.swapMaster)
      -- --       , ((shiftMask,    xK_1)      ,   spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
      --        , ((shiftMask,    xK_1)      ,   scratchpadSpawnActionTerminal "gterm")
      --        , ((0,            xK_p)      ,   spawn "/home/nelhage/bin/viewpdf")
      --        , ((0,            xK_s)      ,   sshPrompt myXPConfig)

      --        , ((shiftMask,    xK_s)      ,   spawn "/usr/bin/tracker-search-tool")
      --        , ((0,            xK_x)      ,   spawn "/home/nelhage/bin/rp-hm-complete.sh")

      --        , ((0,            xK_g)      ,   workspacePrompt  myXPConfig (windows . W.greedyView))
      --        , ((shiftMask,    xK_g)      ,   workspacePrompt  myXPConfig (windows . W.shift))
      --        , ((0,            xK_n)      ,   inputPrompt myXPConfig "Workspace name" ?+ addWorkspace)
      --        , ((shiftMask,    xK_k)      ,   removeWorkspace)

      --        , ((0,            xK_r)      ,   renameWorkspace myXPConfig)
      --        , ((0,            xK_q)      ,   viewScreen 0)
      --        , ((0,            xK_w)      ,   viewScreen 1)
      --        ] ++
      --        [((0, k), windows $ W.greedyView i)
      --         | (i, k) <- zip (take 10 (XMonad.workspaces conf)) [xK_1 ..]
      --        ])
    ]

-- renameWS :: String -> X ()
-- renameWS newTag = windows $ \s -> let old = W.tag $ W.workspace $ W.current s
-- in W.renameTag old newTag s

-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad defaults

main =
  xmonad $
    def
      { modMask = mod4Mask,
        terminal = myTerminal
      }
      `additionalKeysP` [ ((0, F6), spawn $ XMonad.terminal conf),
                          ((0, F17), spawn "dmenu_run")
                        ]

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults =
  defaultConfig
    { -- simple stuff
      terminal = myTerminal,
      -- borderWidth        = myBorderWidth,
      modMask = myModMask
      -- numlockMask        = myNumlockMask,
      -- workspaces         = myWorkspaces,
      -- normalBorderColor  = myNormalBorderColor,
      -- focusedBorderColor = myFocusedBorderColor,

      -- key bindings
      -- keys               = myKeys,
      -- mouseBindings      = myMouseBindings,

      -- hooks, layouts
      -- layoutHook         = myLayout,
      -- manageHook         = myManageHook,
      -- logHook            = myLogHook
    }