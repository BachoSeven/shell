#!/bin/bash
# Usage: Running `sh rebuild.sh` will also save your current dconf entries to restore_personal_shortcuts,
# and then `make uninstall` will run this script

cmd1="dconf write /org/gnome/mutter/wayland/keybindings/restore-shortcuts"
cmd2="dconf write /org/gnome/desktop/wm/keybindings/minimize"
cmd3="dconf write /org/gnome/shell/keybindings/open-application-menu"
cmd4="dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-left"
cmd5="dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-right"
cmd6="dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-left"
cmd7="dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-down"
cmd8="dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-up"
cmd9="dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-right"
cmd10="dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down"
cmd11="dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up"
cmd12="dconf write /org/gnome/mutter/keybindings/toggle-tiled-left"
cmd13="dconf write /org/gnome/mutter/keybindings/toggle-tiled-right"
cmd14="dconf write /org/gnome/desktop/wm/keybindings/toggle-maximized"
cmd15="dconf write /org/gnome/settings-daemon/plugins/media-keys/screensaver"
cmd16="dconf write /org/gnome/settings-daemon/plugins/media-keys/home"
cmd17="dconf write /org/gnome/settings-daemon/plugins/media-keys/email"
cmd18="dconf write /org/gnome/settings-daemon/plugins/media-keys/www"
cmd19="dconf write /org/gnome/settings-daemon/plugins/media-keys/rotate-video-lock-static"
cmd20="dconf write /org/gnome/desktop/wm/keybindings/close"

# Using a not very elegant nested variable substitution
i=1
while IFS= read -r line
do
	cmd=$( tmp=cmd${i} ; echo ${!tmp} )
	arg=$line
	eval $cmd "$arg"
	((i=i+1))
done < shortcuts_tmp && rm shortcuts_tmp
