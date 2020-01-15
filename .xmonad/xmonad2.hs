import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Spacing
import XMonad.Layout.IndependentScreens
import XMonad.Hooks.FadeInactive
import XMonad.Layout.NoBorders
import System.IO
import XMonad.Hooks.SetWMName

import qualified Data.Map as M         -- haskell modules
import qualified XMonad.StackSet as W  -- xmonad core
import XMonad.Actions.FloatKeys        -- actions (keyResizeWindow)
import XMonad.Actions.FloatSnap        -- actions (snapMove)

main = do
    xmproc <- spawnPipe "xmobar"
    spawn "xscreensaver -no-splash"
    spawn "xcompmgr"

    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = smartBorders $
                       avoidStruts $
                       --smartSpacing 4 $
                       Tall 1 (3/100) (1/2)
                       ||| Mirror (Tall 1 (3/100) (1/2))
                       ||| Full
        , logHook = do --fadeInactiveLogHook 0.9
                       dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , startupHook = myStartupHook
        , mouseBindings = myMouseBindings
        , normalBorderColor   = colorNormalBorder
        , focusedBorderColor  = colorFocusedBorder
        , borderWidth         = 2
        , terminal = "xfce4-terminal --hide-menubar"
        -- Define workspaces
        , workspaces = withScreens 2 ["main","web","vim","chat","music","misc"]
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask .|. shiftMask, xK_t), sendMessage ToggleStruts)
        , ((mod4Mask .|. shiftMask, xK_d), spawn "gsimplecal")
        , ((mod4Mask .|. shiftMask, xK_o), spawn "amixer -D pulse sset Master 5%+")
        , ((mod4Mask .|. shiftMask, xK_p), spawn "amixer -D pulse sset Master 5%-")
        , ((mod4Mask .|. shiftMask .|. controlMask, xK_o), spawn "xbacklight -inc 10")
        , ((mod4Mask .|. shiftMask .|. controlMask, xK_p), spawn "xbacklight -dec 10")
        , ((mod4Mask .|. controlMask, xK_n), spawn "google-chrome")
        , ((mod4Mask .|. shiftMask .|. controlMask, xK_n), spawn "google-chrome --incognito")
        , ((0, xK_Print), spawn "ksnapshot")
        ]

myStartupHook = do
                spawn "feh --bg-scale /home/cr0c0/Bilder/wallpaper.png"
                spawn "xsetroot -cursor_name left_ptr"
                setWMName "LG3D" -- Java hack

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Sink the window back to the grid.
    , ((modm, button2), (\w -> withFocused $ windows . W.sink))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))]
--}}}
--  1 -- Theme {{{
--  2 -- Color names are easier to remember:
colorOrange         = "#FD971F"
colorDarkGray       = "#1B1D1E"
colorPink           = "#F92672"
colorGreen          = "#A6E22E"
colorBlue           = "#66D9EF"
colorYellow         = "#E6DB74"
colorWhite          = "#CCCCC6"
colorNormalBorder   = "#CCCCC6"
colorFocusedBorder  = "#fd971f"

-- }}}]
