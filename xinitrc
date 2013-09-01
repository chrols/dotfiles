HOME=/home/chrols
BIN=/home/chrols/src/scripts

pulseaudio --start
setxkbmap -option terminate:ctrl_alt_bksp
#setxkbmap se -variant dvorak
setxkbmap se

#export GTK_IM_MODULE='uim'
#export QT_IM_MODULE='uim'
#export XMODIFIERS=@im='uim'
#uim-xim &


xrdb -merge $HOME/.Xresources&
emacs --daemon&
#xautolock -time 15 -locker "xlock -mode blank"&
/home/chrols/.dropbox-dist/dropboxd&
#xflux -l 58.28&
# unclutter &
# For laptop
# gsynaptics-init&


# Start a D-Bus session
#source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
eval $(gnome-keyring-daemon --start)
# You probably need to do this too:

export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
export GNOME_KEYRING_SOCKET
export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

#xfce4-power-manager&
#deluged&


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
#		$BIN/fix_screen
		$BIN/tray &
		xsetroot -solid black
		feh --bg-fill $HOME/.bg.jpg &
		xsetroot -cursor_name left_ptr &
		nm-applet&
		exec xmonad
		;;
esac


