# hyprland-dotfiles

My Hyprland config (Lua), on Gentoo with OpenRC. The shell on top is the
Quickshell dynamic island from
[quickshell-dotfiles](https://github.com/EnvyMeAdams/quickshell-dotfiles).

```
install.sh                sets everything up (see Install)
hyprland.lua              entry point, loads config/ in order
config/                   one file per topic (monitors, keybinds, autostart…)
xdg-portal-hyprland       starts the desktop portals without systemd
scripts/
  wallpaper-colors        terminal colours from the current wallpaper
kitty/kitty.conf          kitty settings (the terminal in use)
fastfetch/config.jsonc    fastfetch modules + image logo
shell/bashrc              ~/.bashrc (fastfetch with random logo + wallpaper colours)
shell/bash_profile        ~/.bash_profile (starts Hyprland on tty1)
ghostty/config            Ghostty settings (kept as an alternative)
```

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/EnvyMeAdams/hyprland-dotfiles/main/install.sh | sh
```

or, from a clone, `~/.config/hypr/install.sh`. It:

- clones this repo to `~/.config/hypr` (or updates it)
- links kitty, Ghostty, fastfetch, `~/.bashrc` and `~/.bash_profile` into it,
  moving anything it replaces to `<name>.old`
- sets superfile to the wallpaper theme with a see-through background
- clones and installs the Quickshell island
  ([quickshell-dotfiles](https://github.com/EnvyMeAdams/quickshell-dotfiles));
  skip with `--no-island`
- builds the wallpaper colours once
- lists any programs that aren't installed, with the emerge command

It installs no packages and is safe to run again. Put your own pictures in
`~/.config/fastfetch/logos/`; they aren't in the repo.

`config/monitors.lua` is this machine's layout; Quickshell's Display settings
rewrite it, so adjust it on a new machine.

## Terminal colours

`scripts/wallpaper-colors --watch` runs at login. It reads the island's
wallpaper (a still frame for videos), builds a dark, see-through theme tinted to
match, and writes it whenever the wallpaper changes:

- kitty: `~/.config/kitty/themes/wallpaper.conf`. Open windows are recoloured
  right away (the script sends kitty SIGUSR1).
- superfile: `~/.config/superfile/theme/wallpaper.toml`. Used the next time
  `spf` opens. In `~/.config/superfile/config.toml` set `theme = "wallpaper"`
  and `transparent_background = true`.
- Ghostty: `~/.config/ghostty/themes/wallpaper`, if you use it instead.
- fastfetch: `~/.config/fastfetch/wallpaper-colors` (`FF_KEYS`, `FF_TITLE`), passed
  as `--color-keys` / `--color-title` by a `fastfetch` function in `~/.bashrc`.

Needs `dev-python/pillow`, and `ffmpegthumbnailer` for video wallpapers.
