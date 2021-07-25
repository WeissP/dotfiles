{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE KindSignatures #-}

import           Data.List
import qualified Data.Map                      as M
import           Data.Maybe
import           System.IO                      ( hPutStrLn )
import           XMonad
import           XMonad.Actions.MouseResize
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.Accordion
import           XMonad.Layout.DragPane
import           XMonad.Layout.LayoutBuilder
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Spacing
import           XMonad.Layout.Tabbed
import           XMonad.Layout.TwoPane
import           XMonad.Layout.WindowArranger
import           XMonad.Layout.WindowNavigation
import qualified XMonad.StackSet               as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Loggers
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run                ( runProcessWithInput
                                                , safeSpawn
                                                , spawnPipe
                                                )
import           XMonad.Util.Themes
import           XMonad.Util.Ungrab

myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 2 -- Sets border width for windows

myNormColor :: String
myNormColor = "#282c34" -- Border color of normal windows

myFocusColor :: String
myFocusColor = "#46d9ff" -- Border color of focused windows

myModMask = mod4Mask

myWorkspaces :: [WorkspaceId]
myWorkspaces =
    zipWith (\i n -> show i ++ n) [1 .. 9 :: Int]
        $  map (":" ++) ["main", "sub", "fun", "mail", "monitor"]
        ++ repeat ""

mylogLayout :: Logger
mylogLayout = withWindowSet $ return . Just . ld
    where ld = description . W.layout . W.workspace . W.current

-- Gaps around and between windows
-- Changes only seem to apply if I log out then in again
-- Dimensions are given as (Border top bottom right left)
mySpacing = spacingRaw True             -- Only for >1 window
                       -- The bottom edge seems to look narrower than it is
                       (Border 0 0 0 0) -- Size of screen edge gaps
                       True             -- Enable screen edge gaps
                       (Border 5 5 5 5) -- Size of window gaps
                       True             -- Enable window gaps

myLayout =
    avoidStruts
        $   mySpacing
        $   smartBorders
        $   mouseResize
        $   windowArrange
        $   onWorkspace (getWorkspace 1) twoPane
        $   onWorkspace (getWorkspace 2) (Mirror myTall) myTall
        ||| Mirror myTall
  where
    twoPane = TwoPane delta ratio
    myTall  = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1 / 2
    delta   = 3 / 100

myKeys =
    [ ( "<XF86Launch8>"
      , spawn
          "rofi -run-list-command \". /home/weiss/weiss/zsh_aliases.sh\" -run-command \"/bin/zsh -i -c '{cmd}'\" -show run"
      )
        , ("<F6>" , spawn myTerminal)
        , ("<F11>", withFocused toggleFloat)
        , ( "M-3"
          , spawn
              "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi"
          )
        , ("<XF86Launch6>", mySwapMaster)
        , ("M-<Escape>"   , kill)
        , ("M-1"          , myFocusUp)
        , ("M-2"          , myFocusDown)
        -- , ("M-4"          , myTest)
        ]
        ++ [ (keyPrefix ++ " " ++ k, fun i)
           | (k, i) <- zip ["m", ",", ".", "j", "k", "l", "u", "i", "o"]
                           myWorkspaces
           , (keyPrefix, fun) <-
               [ ("<XF86Launch7>"         , switchOrFocus)
               , ("<XF86Launch7> <Space>" , shiftThenSwitchOrFocus)
               , ("<XF86Launch7> <Escape>", windows . W.shift)
               ]
           ]
        ++ [ ("<XF86Launch7> " ++ key, fun)
           | (key, fun) <-
               [ ("n"      , withFocused $ windows . W.sink)
               , ("t"      , sendMessage NextLayout)
               , ("<Left>" , sendMessage $ Move L)
               , ("<Right>", sendMessage $ Move R)
               , ("<Up>"   , sendMessage $ Move U)
               , ("<Down>" , sendMessage $ Move D)
               ]
           ]

myManageHook :: ManageHook
myManageHook = composeAll $ concat
    [ [isDialog --> doFloat]
    , [ className =? x --> doIgnore | x <- myIgnoreClass ]
    , [ className =? x --> doHideIgnore | x <- myHideIgnoreClass ]
    , [ className =? x --> doCenterFloat | x <- myCenterFloatClass ]
    , [ className =? x --> doFullFloat | x <- myFullFloatClass ]
    ]
  where
    myIgnoreClass      = ["trayer"]
    myHideIgnoreClass  = ["Blueman-applet"]
    myCenterFloatClass = ["Blueman-manager"]
    myFullFloatClass   = ["MPlayer"]

myLogHook xmprocs =
    dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
        { ppOutput        = \x -> mapM_ (`hPutStrLn` x) xmprocs
        , ppSep           = magenta " | "
        , ppTitle         = yellow . shorten 100
        , ppTitleSanitize = xmobarStrip
        , ppCurrent       = wrap (blue "[") (blue "]")
        , ppHidden        = white . wrap " " ""
        , ppUrgent        = red . wrap (yellow "!") (yellow "!")
        , ppOrder         = \[ws, l, t] -> [ws, l, t]
        -- , ppExtras        = [logLayout]
        }
  where
    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

myConfig xmprocs =
    def { modMask            = myModMask
        , terminal           = myTerminal
      -- , startupHook        = myStartupHook
        , manageHook         = myManageHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , layoutHook         = myLayout
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook            = myLogHook xmprocs
        , handleEventHook    = handleEventHook def <+> fullscreenEventHook
        }
        -- `removeKeysP` ["M-4"]
        `additionalKeysP` myKeys

main :: IO ()
main = do
    xmprocs <- mapM
        (\file -> spawnPipe $ "xmobar -x 1 /home/weiss/.xmonad/xmobar/" ++ file)
        ["xmobarrc0.hs"]
    xmonad $ ewmh $ docks $ myConfig xmprocs

isMaster :: W.StackSet i l a s sd -> Bool
isMaster ss = case W.stack . W.workspace . W.current $ ss of
    Just (W.Stack _ [] _) -> True
    _                     -> False

trimPrefixWithList :: [String] -> Maybe String -> Maybe String
trimPrefixWithList _  Nothing  = Nothing
trimPrefixWithList xs (Just s) = case mapMaybe (`stripPrefix` s) xs of
    []    -> Just s
    n : _ -> trimPrefixWithList xs (Just n)

trimLayoutModifiers :: Maybe String -> Maybe String
trimLayoutModifiers = trimPrefixWithList ["Spacing", " "]

myFocusDown :: X ()
myFocusDown = do
    l <- logLayout
    case trimLayoutModifiers l of
        Just "TwoPane"     -> windows focusDownTwoPane
        Just "Mirror Tall" -> windows W.focusUp
        _                  -> windows W.focusDown
  where
    focusDownTwoPane :: W.StackSet i l a s sd -> W.StackSet i l a s sd
    focusDownTwoPane = W.modify' $ \stack -> case stack of
        W.Stack r2 (l : r1 : up) down -> W.Stack r1 [l] (r1 : down)
        W.Stack r1 (l : up) (r2 : down) -> W.Stack r2 [l] (r1 : down)
        W.Stack l [] (r1 : r2 : down) -> W.Stack r1 [l] (r2 : down)
        _ -> W.focusDown' stack

myFocusUp :: X ()
myFocusUp = do
    l <- logLayout
    case trimLayoutModifiers l of
        Just "TwoPane"     -> windows focusUpTwoPane
        Just "Mirror Tall" -> windows W.focusDown
        _                  -> windows W.focusUp
  where
    focusUpTwoPane :: W.StackSet i l a s sd -> W.StackSet i l a s sd
    focusUpTwoPane = W.modify' $ \stack -> case stack of
        W.Stack r2 (l : r1 : up) down -> W.Stack l [] (r2 : r1 : down)
        W.Stack r1 (l : up) (r2 : down) -> W.Stack l [] (r1 : r2 : down)
        W.Stack l [] (r1 : r2 : down) -> W.Stack r2 [l] (r1 : down)
        _ -> W.focusUp' stack

mySwapMaster :: X ()
mySwapMaster = do
    l <- logLayout
    case trimLayoutModifiers l of
        Just "TwoPane" -> windows swapMasterTwoPane
        _              -> windows $ W.modify' swapBetweenMasterAndSlave
  where
    swapBetweenMasterAndSlave :: W.Stack a -> W.Stack a
    swapBetweenMasterAndSlave stack = case stack of
        W.Stack f [] [] -> stack
        W.Stack f [] ds -> W.Stack (last ds) [] (f : init ds)
        W.Stack t ls rs -> W.Stack t [] (xs ++ x : rs)
            where (x : xs) = reverse ls
    swapMasterTwoPane :: W.StackSet i l a s sd -> W.StackSet i l a s sd
    swapMasterTwoPane = W.modify' $ \stack -> case stack of
        W.Stack r2 (l : r1 : up) down -> W.Stack r1 [r2] (l : down)
        W.Stack r1 (l : up) (r2 : down) -> W.Stack r2 [r1] (l : down)
        W.Stack l [] (r1 : r2 : down) -> W.Stack l [] (r2 : r1 : down)
        _ -> swapBetweenMasterAndSlave stack




-- | if the workspace is visible in some screen, then focus to this screen, else switch current screen to that workspace
switchOrFocus :: WorkspaceId -> X ()
switchOrFocus ws = switchOrFocusHelp ws 0
  where
    switchOrFocusHelp ws sc = screenWorkspace sc >>= \case
        Nothing -> windows $ W.greedyView ws
        Just x  -> if x == ws
            then windows $ W.view x
            else switchOrFocusHelp ws (sc + 1)

-- from https://www.reddit.com/r/xmonad/comments/hm2tg0/how_to_toggle_floating_state_on_a_window/
toggleFloat :: Window -> X ()
toggleFloat w = windows
    (\s -> if M.member w (W.floating s)
        then W.sink w s
        else W.float w (W.RationalRect 0 0 1 1) s
    )

shiftThenSwitchOrFocus i = do
    windows $ W.shift i
    switchOrFocus i

getWorkspace :: Int -> String
getWorkspace i = myWorkspaces !! (i - 1)
