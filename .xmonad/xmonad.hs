import XMonad
import XMonad.Config.Xfce
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Tabbed
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

-- Import stuff
import XMonad
import qualified XMonad.StackSet as W 
import qualified Data.Map as M
import XMonad.Util.EZConfig(additionalKeys)
import System.Exit
import Graphics.X11.Xlib
import System.IO
 
 
-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import qualified XMonad.Actions.Search as S
import XMonad.Actions.Search
import qualified XMonad.Actions.Submap as SM
import XMonad.Actions.GridSelect
 
-- utils
import XMonad.Util.Scratchpad (scratchpadSpawnAction, scratchpadManageHook, scratchpadFilterOutWorkspace)
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.Prompt 		as P
import XMonad.Prompt.Shell
import XMonad.Prompt
 
 
-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
 
-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
 
-- Data.Ratio for IM layout
import Data.Ratio ((%))
 

-- import Utils
-- import ScratchPadKeys             (scratchPadList, manageScratchPads, scratchPadKeys)
-- import System.IO                  (hPutStrLn)
-- import XMonad.Hooks.DynamicLog    (dynamicLogWithPP, PP(..))
-- import XMonad.Hooks.ManageHelpers (doCenterFloat)

------------------------------------------------------------------------
-- Window rules:
  
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
      
-- hooks
-- automaticly switching app to workspace 

--myWorkspaces = ["1:emacs", "2:web", "3:code", "4:pdf", "5:doc", "6:vbox" ,"7:music", "8:bittorrent", "9:gimp"] 
--myWorkspaces = ["1:web", "2:code", "3:video", "4:music", "5:torrent", "6:doc" ,"7:games", "8:vbox", "9:chat"] 

-- Class name can be determined by xprop |grep WM_CLASS

--Workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1", "2", "3", "4", "5", "6" ,"7", "8", "9"] 
--

myManageHook :: ManageHook
myManageHook = scratchpadManageHook (W.RationalRect 0.25 0.375 0.5 0.35) <+> ( composeAll . concat $
                [[isFullscreen                  --> doFullFloat
                 , className =? "Xmessage" 	    --> doCenterFloat
                 , className =? "Zenity" 	    --> doCenterFloat
                 , className =? "feh" 	            --> doCenterFloat
                 , className =? "Firefox"           --> doShift "1"
                 , className =? "Chromium"           --> doShift "1"
                 , className =? "Emacs"             --> doShift "2"
                 , className =? "MPlayer"	--> doCenterFloat
                 , className =? "Clementine"	--> doShift "4"
                 , className =? "Deluge"	--> doShift "5"
                 , className =? "games-strategy-engine-framework-GameRunner" --> doShift "7"
                 , className =? "bsnes"	--> doShift "7"
                 , className =? "OpenOffice.org 3.1" --> doShift "6"
                 , className =? "Pidgin"           --> doShift "9"
                 , className =? "Skype"           --> doShift "9"
                 , className =? "VirtualBox"	--> doShift "8"
                 , className =? "avidemux2_gtk" --> doShift "6"
                 , className =? "Avidemux2_gtk" --> doShift "6"
                 , className =? "zsnes"        --> doCenterFloat

                 ]
 
		]
                        )  <+> manageDocks

--logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }
 
---- Looks --
---- bar
customPP :: PP
customPP = defaultPP { 
     			    ppHidden = xmobarColor "#00FF00" ""
			  , ppCurrent = xmobarColor "#FF0000" "" . wrap "[" "]"
			  , ppUrgent = xmobarColor "#FF0000" "" . wrap "*" "*"
                          , ppLayout = xmobarColor "#FF0000" ""
                          , ppTitle = xmobarColor "#00FF00" "" . shorten 80
                          , ppSep = "<fc=#0033FF> | </fc>"
                     }
 
-- some nice colors for the prompt windows to match the dzen status bar.
myXPConfig = defaultXPConfig                                    
    { 
	font  = "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-u" 
	,fgColor = "#00FFFF"
	, bgColor = "#000000"
	, bgHLight    = "#000000"
	, fgHLight    = "#FF0000"
	, position = Top
    }
 
--- My Theme For Tabbed layout
myTheme = defaultTheme { decoHeight = 16
                        , activeColor = "#a6c292"
                        , activeBorderColor = "#a6c292"
                        , activeTextColor = "#000000"
                        , inactiveBorderColor = "#000000"
                        }
 
--LayoutHook

myLayoutHook  =  
--                 onWorkspace "1" webL $ 
--                 onWorkspace "2" codeL $  
--                 onWorkspace "3" fullL $                  
--                 onWorkspace "4" fullL $                                   
--                 onWorkspace "5" fullL $                                   
--                 onWorkspace "6" fullL $ 
--                 onWorkspace "7" fullL $ 
                 onWorkspace "9" imLayout $ 
                 standardLayouts 
  
  where
	standardLayouts =   avoidStruts  $ (noBorders Full ||| tiled ||| Mirror tiled ||| Grid) 
 
        --Layouts
	tiled     = smartBorders (ResizableTall 1 (2/100) (1/2) [])
        reflectTiled = (reflectHoriz tiled)
	tabLayout = noBorders (tabbed shrinkText myTheme)
	full 	  = noBorders Full
 
        --Im Layout
        imLayout = avoidStruts $ smartBorders $ withIM ratio pidginRoster $ reflectHoriz $ withIM skypeRatio skypeRoster (tiled ||| reflectTiled ||| Grid) where
                chatLayout      = Grid
	        ratio = (1%9)
                skypeRatio = (1%8)
                pidginRoster    = And (ClassName "Pidgin") (Role "buddy_list")
                skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "Chats")) `And` (Not (Role "CallWindowForm"))
 
	--Gimp Layout
--	gimpL = avoidStruts $ smartBorders $ withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full 
 
	--Web Layout
	webL      = avoidStruts $  full ||| tabLayout  ||| tiled ||| reflectHoriz tiled ||| Grid        
	codeL      = avoidStruts $  full ||| tiled ||| reflectHoriz tiled ||| Grid
 
        --VirtualLayout
        fullL = avoidStruts $ full ||| tiled ||| Grid
    
-- borders
myBorderWidth :: Dimension
myBorderWidth = 1
--  
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = "#333333"
myFocusedBorderColor = "#FF0000"
--
   
-- Switch to the "web" workspace
viewWeb = windows (W.greedyView "1")                           -- (0,0a)

main = do
  xmproc <- spawnPipe "xmobar"  -- start xmobar  
  spawn "pkill -f trayer"
  spawn "/home/chrols/src/scripts/tray"
  xmonad $ defaultConfig 
        { modMask = mod4Mask        
--        , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"          -- Hold Java's hand
        , layoutHook = myLayoutHook
        , terminal = "exo-open --launch TerminalEmulator"
        , manageHook = myManageHook
        , borderWidth = 1
        , normalBorderColor = "#60A1AD"
        , focusedBorderColor = "#ff0000" 
        , logHook = myLogHook xmproc
        , workspaces = myWorkspaces
        , focusFollowsMouse = True
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_e), spawn "emacsclient -c") 
        , ((mod4Mask .|. shiftMask, xK_t), spawn "dolphin")
        , ((mod4Mask .|. shiftMask, xK_f), spawn "firefox")        
        , ((mod4Mask .|. shiftMask, xK_d), spawn "deluge")
        , ((mod4Mask .|. shiftMask, xK_m), spawn "clementine")        
        , ((mod4Mask .|. shiftMask, xK_l), spawn "xlock -mode blank")                           
        --, ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
        --, ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)
        
          
        , ((0, xK_section), spawn "exo-open --launch TerminalEmulator")

        , ((mod4Mask, xK_b), sendMessage ToggleStruts)           
        , ((mod4Mask, xK_p), spawn "exe=`dmenu_run  -fn '-misc-fixed-*-*-*-*-15-*-*-*-*-*-*-*' -nb black -sf grey` && eval \"exec $exe\"")
           
        , ((mod4Mask, xK_F3), spawn "/usr/bin/dmenu_run  -fn '-misc-fixed-*-*-*-*-15-*-*-*-*-*-*-*' -nb 'black' -sf 'grey'")
          
        , ((mod4Mask .|. shiftMask, xK_F1), spawn "setxkbmap se")
        , ((mod4Mask .|. shiftMask, xK_F2), spawn "setxkbmap se -variant dvorak")

        , ((mod4Mask .|. shiftMask, xK_F10), spawn "systemctl poweroff")                    
        , ((mod4Mask .|. shiftMask, xK_F11), spawn "systemctl reboot")                    
        , ((mod4Mask .|. shiftMask, xK_F12), spawn "systemctl suspend")          
          

          
        , ((0 , 0x1008ff18), spawn "/usr/bin/firefox http://www.reddit.com") -- 0x1008ff18, XF86HomePage
        , ((0 , 0x1008ff19), spawn "/usr/bin/firefox http://www.gmail.com")  -- 0x1008ff19, XF86Mail
        , ((0 , 0x1008ff1b), spawn "/usr/bin/firefox http://www.gmail.com")  -- 0x1008ff1b, XF86Search 

          -- 0x1008ff45, XF86Launch5
        , ((0 , 0x1008ff45), spawn "/usr/local/eclipse/eclipse")                              
        , ((0 , 0x1008ff46), spawn "VirtualBox")           
        , ((0 , 0x1008ff47), spawn "xfsettingsd --replace --sync")           
        , ((0 , 0x1008ff48), spawn "/usr/local/bin/fix_screen")
        , ((0 , 0x1008ff49), spawn "/usr/bin/firefox http://www.gmail.com")                              
          
        , ((0 , 0x1008ff30), spawn "/usr/bin/firefox http://www.gmail.com")     -- 0x1008ff30, XF86Favorites
        , ((0 , 0x1008ff1d), spawn "exo-open --launch TerminalEmulator python") -- 0x1008ff1d, XF86Calculator
          
        , ((0 , 0x1008ff12), spawn "amixer -q set Master toggle")     -- XF86AudioMute
          

--        , ((0 , 0x1008ff11), spawn "pactl set-sink-volume alsa_output.pci-0000_00_14.2.analog-stereo -- -5%") -- XF86AudioLowerVolume
  --      , ((0 , 0x1008ff13), spawn "pactl set-sink-volume alsa_output.pci-0000_00_14.2.analog-stereo -- +5%") -- XF86AudioRaiseVolume
          
         , ((0 , 0x1008ff11), spawn "amixer -q set Master  1- unmute") -- XF86AudioLowerVolume
         , ((0 , 0x1008ff13), spawn "amixer -q set Master 1+ unmute")  -- XF86AudioRaiseVolume
          
        , ((mod4Mask, xK_Print), spawn "sleep 2; export DISPLAY=:0.0 ; /usr/local/bin/scrot_now")
        , ((0, xK_Print), spawn "export DISPLAY=:0.0 ; /usr/local/bin/scrot_now")
        ]



