# hyprland-dotfiles

My Hyprland config (Lua), on Gentoo with OpenRC. The shell on top is the
Quickshell dynamic island from
[quickshell-dotfiles](https://github.com/EnvyMeAdams/quickshell-dotfiles).

```
hyprland.lua              entry point, loads config/ in order
config/                   one file per topic (monitors, keybinds, autostart…)
xdg-portal-hyprland       starts the desktop portals without systemd
scripts/
  ghostty-wallpaper-theme Ghostty colours from the current wallpaper
ghostty/config            Ghostty settings
```

## Install

```sh
git clone https://github.com/EnvyMeAdams/hyprland-dotfiles ~/.config/hypr
mkdir -p ~/.config/ghostty
ln -sf ~/.config/hypr/ghostty/config ~/.config/ghostty/config
```

`config/monitors.lua` is this machine's layout; Quickshell's Display settings
rewrite it, so adjust it on a new machine.

## Ghostty colours

`scripts/ghostty-wallpaper-theme --watch` runs at login. It reads the island's
wallpaper (a still frame for videos), builds a dark, see-through theme tinted to
match, and writes it to `~/.config/ghostty/themes/wallpaper` whenever the
wallpaper changes. New windows pick it up; press Ctrl+Shift+, in an open one.

Needs `dev-python/pillow`, and `ffmpegthumbnailer` for video wallpapers.
