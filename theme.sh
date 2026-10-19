#!/bin/sh

[ "$1" = "period-changed" ] || exit 0

case "$3" in
    daytime)
        theme="Adwaita"
        scheme="prefer-light"
        ;;
    night)
        theme="Adwaita-dark"
        scheme="prefer-dark"
        ;;
    *)
        exit 0
        ;;
esac

xfconf-query -c xsettings -p /Net/ThemeName -s "$theme"
gsettings set org.gnome.desktop.interface color-scheme "$scheme"


# Preserve your window manager theme
xfconf-query -c xfwm4 -p /general/theme -s "Daloa"

