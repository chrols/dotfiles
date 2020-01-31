HOME=/home/chrols

# A necessary evil these days
pulseaudio --start

# Enable terminate on Ctrl-Alt-Backspace
setxkbmap -option terminate:ctrl_alt_bksp

# Use my custom Dvorak layout
setxkbmap se -variant dvorak_a5

# Change the caps-lock key into a Hyper key
xmodmap -e "keysym Caps_Lock = Hyper_L"
xmodmap -e "remove Mod4 = Hyper_L"
xmodmap -e "remove lock = Hyper_L"
xmodmap -e "add Mod3 = Hyper_L"

# Disable bell
xset -b

export PATH=$PATH:$HOME/bin
xrdb -merge $HOME/.Xresources&

# Start stuff
rdm&
nextcloud&
emacs --daemon&
redshift&

case "$1" in
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
		random-bg.py
		exec xmonad
		;;
esac


