HOME=/home/chrols

# Enable terminate on Ctrl-Alt-Backspace
setxkbmap -option terminate:ctrl_alt_bksp

setxkbmap se

# Change the caps-lock key into a Hyper key
xmodmap -e "keysym Caps_Lock = Hyper_L"
xmodmap -e "remove Mod4 = Hyper_L"
xmodmap -e "remove lock = Hyper_L"
xmodmap -e "add Mod3 = Hyper_L"
xmodmap -e "keysym Menu = Multi_key"

# Disable bell
xset -b

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export PATH=$PATH:$HOME/bin
xrdb -merge $HOME/.Xresources&

# Start stuff
rdm&

# emacs --daemon&

export PATH=$PATH:/home/chrols/.local/bin

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
	xmonad)
		xsetroot -solid black
		xsetroot -cursor_name left_ptr &
		nm-applet&
                nextcloud&
                redshift&
		random-bg.py
		exec xmonad
		;;
	i3|*)
            xrandr --output DP-2 --mode 3840x2160 --rate 119.91
            export QT_QPA_PLATFORMTHEME="qt5ct"
	    exec i3
	    ;;
esac
