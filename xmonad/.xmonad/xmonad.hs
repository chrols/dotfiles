import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

import XMonad.Prompt

import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Scratchpad (scratchpadManageHook)

import Data.Char (isSpace)
import System.IO
import Text.Printf

import qualified Data.List as List
import qualified XMonad.StackSet as W

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
myWorkspaces = ["1", "2", "3", "4", "5", "6" ,"7", "8", "9","A","B"]
--

myManageHook :: ManageHook
myManageHook = scratchpadManageHook (W.RationalRect 0.25 0.375 0.5 0.35) <+> ( composeAll . concat $
                [[isFullscreen                  --> doFullFloat
                 , isDialog --> doCenterFloat
                 , className =? "Xmessage" 	    --> doCenterFloat
                 , className =? "Zenity" 	    --> doCenterFloat
                 , className =? "feh" 	            --> doCenterFloat
                 , className =? "Firefox"           --> doShift "1"
                 , className =? "Chromium"          --> doShift "1"
                 , className =? "Emacs"             --> doShift "2"
                 , className =? "QtCreator"         --> doShift "3"
                 , className =? "MPlayer"	--> doCenterFloat
                 , className =? "mplayer2"	--> doCenterFloat
                 , className =? "mpv"	        --> doCenterFloat
                 , className =? "Clementine"	--> doShift "5"
                 , className =? "Spotify"	--> doShift "5"
                 , className =? "Deluge"	--> doShift "5"
                 , className =? "Skype"           --> doShift "9"
                 , className =? "VirtualBox"	--> doShift "8"
                 , className =? "avidemux2_gtk" --> doShift "6"
                 , className =? "Avidemux2_gtk" --> doShift "6"
                 , className =? "Steam" --> doFloat
                 , className =? "steam" --> doFullFloat
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
-- myNormalBorderColor, myFocusedBorderColor :: String
-- myNormalBorderColor = "#333333"
-- myFocusedBorderColor = "#FF0000"
--

-- Switch to the "web" workspace
viewWeb = windows (W.greedyView "1")                           -- (0,0a)

------------------------------------------------------------------------
-- Xmobar configuration
------------------------------------------------------------------------

myNormalBorderColor :: String
myNormalBorderColor  = "#dcdccc"

myFocusedBorderColor :: String
myFocusedBorderColor = "#de7168"

myXmobarFgColor :: String
myXmobarFgColor = myNormalBorderColor

myXmobarBgColor :: String
myXmobarBgColor = "#000000"

myXmobarHiColor :: String
myXmobarHiColor = "#575757"

myXmobarCursorColor :: String
myXmobarCursorColor  = "#ff8278"

myXmobarColorNormal :: String
myXmobarColorNormal = "blue"

myXmobarColorBad :: String
myXmobarColorBad = myXmobarCursorColor

myXmobarColorGood :: String
myXmobarColorGood = "#9ec400"

myXFTFont :: String
-- myXFTFont = "xft:DejaVu Sans Mono for Powerline-10:antialias=true"
myXFTFont =  "-misc-fixed-*-*-*-*-14-*-*-*-*-*-*-*"

xmobarComParameters :: [String] -> String
xmobarComParameters [] = " [] "
xmobarComParameters c  = " [\"" ++ List.intercalate "\",\"" c ++ "\"] "

xmobarLook :: String
xmobarLook = concat
  [ " --font=\"", myXFTFont, "\""
  , " --bgcolor=\"", myXmobarBgColor, "\""
  , " --fgcolor=\"", myXmobarFgColor, "\""
  ]

xmobarStdin :: String
xmobarStdin =
  "Run StdinReader"

xmobarCommand :: String -> [String] -> String -> Integer -> String
xmobarCommand c p = printf "Run Com \"%s\" %s \"%s\" %d" c (xmobarComParameters p)

xmobarCpuTemp :: String -> Integer -> String
xmobarCpuTemp = xmobarCommand "xmobar-cputemp" ["red", "lightblue", "green"]

xmobarGpuTemp :: String -> Integer -> String
xmobarGpuTemp = xmobarCommand "xmobar-gputemp" ["red", "lightblue", "green"]

xmobarVolume :: String -> Integer -> String
xmobarVolume = xmobarCommand "xmobar-volume" []

xmobarTopProc :: Integer -> String
xmobarTopProc rr = concat
  [ "Run TopProc []"
  , show rr
  ]

-- Weather stations:
--
-- ESSL Linkoping
-- ESSP Norrkoping
-- ESOW Vasteras

xmobarWeather :: String -> Integer -> String
xmobarWeather station rr = concat
  [ "Run Weather \"" ++ station ++ "\""
  , xmobarComParameters ["-t", "<tempC>"
                        ,"-L", "14"
                        ,"-H", "25"
                        ,"--normal", "green"
                        ,"--high", "red"
                        ,"--low", "lightblue"
                        ]
  , show rr
  ]

xmobarMultiCpu ::  Integer -> String
xmobarMultiCpu rr = concat
  [ "Run MultiCpu"
  , xmobarComParameters ["-t","CPU:<total0><total1><total2><total3>"
                        ,"-L","2"
                        ,"-H","50"
                        ,"--normal","#CEFFAC"
                        ,"--high","#FFB6B0"
                        ,"-w","4"
                        ]
  , show rr
  ]

xmobarDynNetwork ::  Integer -> String
xmobarDynNetwork rr = concat
  [ "Run DynNetwork"
  , xmobarComParameters [
                        "-L","2"
                        ,"-H","50"
                        ,"--normal","#CEFFAC"
                        ,"--high","#FFB6B0"
                        ]
  , show rr
  ]

xmobarBattery :: Integer -> String
xmobarBattery rr = concat
  [ "Run BatteryP"
  , xmobarComParameters [ "BAT0" ]
  , xmobarComParameters [ "--template", "<acstatus>:<left>%" -- : <timeleft>h"
                        , "--Low"     , "10"
                        , "--High"    , "80"
                        , "--low"     , myXmobarColorBad
                        , "--normal"  , myXmobarFgColor
                        , "--high"    , myXmobarColorGood
                        , "--"
                        , "-o", "<fc=" ++ myXmobarColorBad  ++ ">-</fc>"
                        , "-O", "<fc=" ++ myXmobarColorGood ++ ">+</fc>"
                        , "-i", "<fc=" ++ myXmobarFgColor   ++ ">F</fc>"
                        ]
  , show rr
  ]

xmobarMemory :: Integer -> String
xmobarMemory rr = concat
  [ "Run Memory"
  , xmobarComParameters [ "--template", "RAM : <usedratio>%"
                        , "--Low"     , "20"
                        , "--High"    , "90"
                        , "--low"     , myXmobarColorGood
                        , "--normal"  , myXmobarFgColor
                        , "--high"    , myXmobarColorBad
                        ]
  , show rr
  ]


xmobarDate :: Integer -> String
-- xmobarDate rr = "Run Date \"%H:%M:%S\" \"date\" " ++ show rr
xmobarDate rr = "Run Date \"%a %b %d - %H:%M:%S\" \"date\" " ++ show rr

xmobarCommands :: [String] -> String
xmobarCommands c = " --commands=\'[" ++ List.intercalate ", " c ++ "]\'"

xmobarPipe :: String -> String -> String
xmobarPipe f a = "Run PipeReader \"" ++ f ++ "\" \"" ++ a ++ "\""


xmobarTemplate :: String -> String
xmobarTemplate "athena" =
  xmobarCommands [ xmobarStdin
                 , xmobarTopProc 20
                 , xmobarMultiCpu 20
                 , xmobarMemory 100
                 , xmobarDynNetwork 100
                 , xmobarCpuTemp "cputemp" 60
                 , xmobarGpuTemp "gputemp" 60
                 , xmobarVolume "volume" 10
                 , xmobarWeather "ESSP" 36000
                 , xmobarDate 10
                 ]
  ++ " -t \'%StdinReader%}{ %top% %multicpu% %memory%  %dynnetwork% CPU: %cputemp% GPU: %gputemp% Ute: %ESSP% | %volume% <fc=#ee9a00>%date%</fc> \'"

xmobarTemplate "hecate" =
  xmobarCommands [ xmobarStdin
                 , xmobarTopProc 20
                 , xmobarMultiCpu 20
                 , xmobarMemory 100
                 , xmobarDynNetwork 600
                 , xmobarWeather "ESSP" 36000
                 , xmobarBattery 10
                 , xmobarDate 10
                 ]
  ++ " -t \'%StdinReader%}{ %top% %multicpu% %memory%  %dynnetwork% Ute: %ESSP% %battery% <fc=#ee9a00>%date%</fc> \'"


xmobarTemplate _ = ""

xmobarParameters :: String -> String
xmobarParameters h = xmobarLook ++ xmobarTemplate h


rstrip :: String -> String
rstrip = reverse . dropWhile isSpace . reverse

main :: IO()
main = do
  hostName <- readFile "/etc/hostname"
  xmobar <- spawnPipe ("xmobar" ++ xmobarParameters (rstrip hostName))
  spawn "pkill -f trayer"
  spawn "tray"
  spawn "xfsettingsd"

  xmonad $ defaultConfig
        {
         modMask = mod4Mask
--        , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"          -- Hold Java's hand
        , startupHook = setWMName "LG3D"
        , layoutHook = myLayoutHook
        , terminal =  "urxvt"
        , manageHook = myManageHook
        , borderWidth = 1
        , normalBorderColor = "#60A1AD"
        , focusedBorderColor = "#ff0000"
        , logHook = myLogHook xmobar
        , workspaces = myWorkspaces
        , focusFollowsMouse = True
        } `additionalKeys`

        [ ((mod4Mask , xK_F1), spawn "firefox")
        , ((mod4Mask , xK_F2), spawn "emacsclient -c")
        , ((mod4Mask , xK_F3), spawn "~/bin/dolphin")
        , ((mod4Mask , xK_F4), spawn "spotify")
        , ((mod4Mask , xK_F5), spawn "deluge")
         , ((mod4Mask .|. shiftMask, xK_f), spawn "firefox")
         , ((mod4Mask .|. shiftMask, xK_e), spawn "emacsclient -c")
         , ((mod4Mask .|. shiftMask, xK_r), spawn "random-bg.py")
         , ((mod4Mask .|. shiftMask, xK_t), spawn "~/bin/dolphin")
         , ((mod4Mask .|. shiftMask, xK_d), spawn "deluge")
         , ((mod4Mask .|. shiftMask, xK_m), spawn "spotify")
         , ((mod4Mask .|. shiftMask, xK_l), spawn "i3lock -c 000000")
        -- , ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
        -- , ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)


        , ((0, xK_section), spawn "urxvt")

        , ((mod4Mask, xK_b), sendMessage ToggleStruts)
        , ((mod4Mask, xK_p), spawn "exe=`dmenu_run  -fn '-misc-fixed-*-*-*-*-15-*-*-*-*-*-*-*' -nb black -sf grey` && eval \"exec $exe\"")
        , ((mod4Mask, xK_F3), spawn "/usr/bin/dmenu_run  -fn '-misc-fixed-*-*-*-*-15-*-*-*-*-*-*-*' -nb 'black' -sf 'grey'")

        , ((mod4Mask .|. shiftMask, xK_F1), spawn "setxkbmap se")
        , ((mod4Mask .|. shiftMask, xK_F2), spawn "setxkbmap se -variant dvorak_a5")
        , ((mod4Mask .|. shiftMask, xK_F3), spawn "xrandr --auto")

        , ((mod4Mask .|. shiftMask, xK_F10), spawn "systemctl poweroff")
        , ((mod4Mask .|. shiftMask, xK_F11), spawn "systemctl reboot")
        , ((mod4Mask .|. shiftMask, xK_F12), spawn "systemctl suspend")

        , ((0 , 0x1008ff18), spawn "/usr/bin/firefox http://news.ycombinator.com") -- 0x1008ff18, XF86HomePage
        , ((0 , 0x1008ff19), spawn "/usr/bin/firefox http://mail.chrols.se")  -- 0x1008ff19, XF86Mail
        , ((0 , 0x1008ff1b), spawn "/usr/bin/firefox http://www.google.com")  -- 0x1008ff1b, XF86Search

        , ((mod4Mask , xK_Up), spawn "media-ctrl play")
        , ((mod4Mask , xK_Right), spawn "media-ctrl next")
        , ((mod4Mask , xK_Left), spawn "media-ctrl previous")
        , ((0 , 0x1008ff14), spawn "media-ctrl play") -- XF86AudioPlay
        , ((0 , 0x1008ff27), spawn "media-ctrl next") -- XF86AudioNext
        , ((0 , 0x1008ff26), spawn "media-ctrl prev") -- XF86AudioPrev

          -- 0x1008ff45, XF86Launch5
        , ((0 , 0x1008ff45), spawn "dolphin")
        , ((0 , 0x1008ff46), spawn "deluge")
        , ((0 , 0x1008ff47), spawn "steam")
        , ((0 , 0x1008ff48), spawn "firefox")
        , ((0 , 0x1008ff49), spawn "ynab")
        , ((0 , 0x1008ff30), spawn "emacs")     -- 0x1008ff30, XF86Favorites
        , ((0 , 0x1008ff1d), spawn "exo-open --launch TerminalEmulator python") -- 0x1008ff1d, XF86Calculator

        , ((0 , 0x1008ff12), spawn "amixer -q set Master toggle")     -- XF86AudioMute
        , ((mod4Mask , xK_Page_Down), spawn "xmobar-volume down")
        , ((mod4Mask , xK_Page_Up), spawn "xmobar-volume up")
        , ((0 , 0x1008ff11), spawn "xmobar-volume down") -- XF86AudioLowerVolume
        , ((0 , 0x1008ff13), spawn "xmobar-volume up") -- XF86AudioRaiseVolume

        , ((mod4Mask, xK_Print), spawn "sleep 2; export DISPLAY=:0.0 ; /home/chrols/src/scripts/scrot_now")
        , ((0, xK_Print), spawn "export DISPLAY=:0.0 ; /home/chrols/src/scripts/scrot_now")
        ]
-- e4 f6
