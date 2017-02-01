HOME=/home/chrols
BIN=/home/chrols/src/scripts

pulseaudio --start
setxkbmap -option terminate:ctrl_alt_bksp

setxkbmap se -variant dvorak_a5
xset -b

export PATH=$PATH:$HOME/bin

xrdb -merge $HOME/.Xresources&
emacs --daemon&
$HOME/.dropbox-dist/dropboxd&
redshift&

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
		xsetroot -solid black
		xsetroot -cursor_name left_ptr &
		nm-applet&
		exec xmonad
		;;
esac


