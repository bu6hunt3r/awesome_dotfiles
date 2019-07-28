import XMonad

-- Import statements
import XMonad
import Control.Monad
import qualified XMonad.StackSet as W
 
-- Define the names of all workspaces
myWorkspaces = ["main","web","chat","media","browse","dev","mail"]
 
-- Define the workspace an application has to go to
myManageHook = composeAll . concat $
    [
          -- Applications that go to web
        [ className =? b --> viewShift "web"      | b <- myClassWebShifts  ]
         -- Applications that go to chat
      , [ resource  =? c --> doF (W.shift "chat") | c <- myClassChatShifts ]
    ]
    where
        viewShift = doF . liftM2 (.) W.greedyView W.shift
        myClassWebShifts  = ["firefox"]
        myClassChatShifts = ["Pidgin" ]
 
-- Run XMonad
main = do
    xmonad $ defaultConfig {
        workspaces = myWorkspaces
      , manageHook = myManageHook
      , modMask     = mod4Mask
      , terminal    = "xfce4-terminal --hide-menubar" 
	  , borderWidth = 3
    }
