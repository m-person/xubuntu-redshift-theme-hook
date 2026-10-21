#!/bin/sh

# Switch between light and dark themes on Xfce, including the color scheme.
# Can be used as a Redshift hook or triggered manually.
# Usage:
#   ./theme.sh                              Toggle based on the current theme.
#   Unrecognized themes default to light when toggling.
#   ./theme.sh period-changed OLD daytime   Apply the light theme.
#   ./theme.sh period-changed OLD night     Apply the dark theme.
# OLD is the previous period (ignored). Unsupported events/periods are ignored.

LIGHT_THEME="Adwaita"
DARK_THEME="Adwaita-dark"
WINDOW_MANAGER_THEME="Daloa"

apply_theme() {
    # Arguments: $1 = theme, $2 = scheme
    xfconf-query -c xsettings -p /Net/ThemeName -s "$1" || return "$?"
    gsettings set org.gnome.desktop.interface color-scheme "$2" || return "$?"

    # Apply the configured window manager theme in both modes.
    xfconf-query -c xfwm4 -p /general/theme -s "$WINDOW_MANAGER_THEME"
}

toggle_mode() (
    # A subshell keeps current_theme scoped to this function in POSIX sh.
    current_theme=$(xfconf-query -c xsettings -p /Net/ThemeName) || return "$?"

    if [ "$current_theme" = "$LIGHT_THEME" ]; then
        apply_theme "$DARK_THEME" "prefer-dark"
    else
        apply_theme "$LIGHT_THEME" "prefer-light"
    fi
)

if [ "$#" -eq 0 ]; then
    toggle_mode
elif [ "$1" = "period-changed" ]; then
    case "${3-}" in
        daytime)
            apply_theme "$LIGHT_THEME" "prefer-light"
            ;;
        night)
            apply_theme "$DARK_THEME" "prefer-dark"
            ;;
    esac
fi
