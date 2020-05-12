set -xe

# Build and install extension
make all
make install

left="h"
down="j"
up="k"
right="l"

KEYS_GNOME_WM=/org/gnome/desktop/wm/keybindings
KEYS_GNOME_SHELL=/org/gnome/shell/keybindings
KEYS_MUTTER=/org/gnome/mutter/keybindings
KEYS_MEDIA=/org/gnome/settings-daemon/plugins/media-keys

## Shortcuts: we save current bindings before overwriting

# Disable incompatible shortcuts
# Restore the keyboard shortcuts: disable <Super>Escape
echo "\"$(dconf read /org/gnome/mutter/wayland/keybindings/restore-shortcuts)\"" >> shortcuts_tmp
dconf write /org/gnome/mutter/wayland/keybindings/restore-shortcuts "@as []"
# Hide window: disable <Super>h
echo "\"$(dconf read ${KEYS_GNOME_WM}/minimize)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/minimize "@as ['<Super>comma']"
# Open the application menu: disable <Super>m
echo "\"$(dconf read ${KEYS_GNOME_SHELL}/open-application-menu)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_SHELL}/open-application-menu "@as []"
# Switch to workspace left: disable <Super>Left
echo "\"$(dconf read ${KEYS_GNOME_WM}/switch-to-workspace-left)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-left "@as []"
# Switch to workspace right: disable <Super>Right
echo "\"$(dconf read ${KEYS_GNOME_WM}/switch-to-workspace-right)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-right "@as []"

# Super + direction keys, move window left and right monitors, or up and down workspaces
# Move window one monitor to the left
echo "\"$(dconf read ${KEYS_GNOME_WM}/move-to-monitor-left)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/move-to-monitor-left "['<Shift><Super>Left','<Shift><Super>${left}']"
# Move window one workspace down
echo "\"$(dconf read ${KEYS_GNOME_WM}/move-to-workspace-down)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/move-to-workspace-down "['<Shift><Super>Down','<Shift><Super>${down}']"
# Move window one workspace up
echo "\"$(dconf read ${KEYS_GNOME_WM}/move-to-workspace-up)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/move-to-workspace-up "['<Shift><Super>Up','<Shift><Super>${up}']"
# Move window one monitor to the right
echo "\"$(dconf read ${KEYS_GNOME_WM}/move-to-monitor-right)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/move-to-monitor-right "['<Shift><Super>Right','<Shift><Super>${right}']"

# Super + Ctrl + direction keys, change workspaces, move focus between monitors
# Move to workspace below
echo "\"$(dconf read ${KEYS_GNOME_WM}/switch-to-workspace-down)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-down "['<Primary><Super>Down','<Primary><Super>${down}']"
# Move to workspace above
echo "\"$(dconf read ${KEYS_GNOME_WM}/switch-to-workspace-up)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/switch-to-workspace-up "['<Primary><Super>Up','<Primary><Super>${up}']"

# Disable tiling to left / right of screen
echo "\"$(dconf read ${KEYS_MUTTER}/toggle-tiled-left)\"" >> shortcuts_tmp
dconf write ${KEYS_MUTTER}/toggle-tiled-left "@as []"
echo "\"$(dconf read ${KEYS_MUTTER}/toggle-tiled-right)\"" >> shortcuts_tmp
dconf write ${KEYS_MUTTER}/toggle-tiled-right "@as []"

# Toggle maximization state
echo "\"$(dconf read ${KEYS_GNOME_WM}/toggle-maximized)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/toggle-maximized "['<Super>m']"
# Lock screen
echo "\"$(dconf read ${KEYS_MEDIA}/screensaver)\"" >> shortcuts_tmp
dconf write ${KEYS_MEDIA}/screensaver "['<Super>Escape']"
# Home folder
echo "\"$(dconf read ${KEYS_MEDIA}/home)\"" >> shortcuts_tmp
dconf write ${KEYS_MEDIA}/home "['<Super>f']"
# Launch email client
echo "\"$(dconf read ${KEYS_MEDIA}/email)\"" >> shortcuts_tmp
dconf write ${KEYS_MEDIA}/email "['<Super>e']"
# Launch web browser
echo "\"$(dconf read ${KEYS_MEDIA}/www)\"" >> shortcuts_tmp
dconf write ${KEYS_MEDIA}/www "['<Super>b']"
# Rotate Video Lock
echo "\"$(dconf read ${KEYS_MEDIA}/rotate-video-lock-static)\"" >> shortcuts_tmp
dconf write ${KEYS_MEDIA}/rotate-video-lock-static "@as []"

# Close Window
echo "\"$(dconf read ${KEYS_GNOME_WM}/close)\"" >> shortcuts_tmp
dconf write ${KEYS_GNOME_WM}/close "['<Super>q']"

# Use a window placement behavior which works better for tiling
gnome-extensions enable native-window-placement

# Enable extension
make enable

make restart-shell
make listen
