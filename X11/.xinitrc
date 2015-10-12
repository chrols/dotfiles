HOME=/home/chrols
BIN=/home/chrols/src/scripts

pulseaudio --start
setxkbmap -option terminate:ctrl_alt_bksp
#setxkbmap se -variant dvorak
setxkbmap se
xset -b

export PATH=$PATH:$HOME/bin

xrdb -merge $HOME/.Xresources&
emacs --daemon&
#xautolock -time 15 -locker "xlock -mode blank"&
$HOME/.dropbox-dist/dropboxd&
#xflux -l 58.28&
# unclutter &
# For laptop
# gsynaptics-init&


case $1 in
	wmaker)
		feh --bg-fill $HOME/.bg.jpg
		exec wmaker
		;;
	xfce)
		exec startxfce4
		;;
	kde)
		exec startkde
		;;
	xmonad|*)
		$BIN/start_xfsettingsd.sh &
#		#$BIN/fix_screen
		#$BIN/tray &
		xsetroot -solid black
		#feh --bg-fill $HOME/.bg.jpg &
		xsetroot -cursor_name left_ptr &
		nm-applet&
		exec xmonad
		;;
esac


