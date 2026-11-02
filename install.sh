#!/bin/sh
# Installs these dotfiles for the current user.
#
#   From GitHub:  curl -fsSL https://raw.githubusercontent.com/EnvyMeAdams/hyprland-dotfiles/main/install.sh | sh
#   From a clone: ~/.config/hypr/install.sh
#
#   --no-island   skip the Quickshell island (quickshell-dotfiles)
#
# Safe to run again: anything it would replace is moved to <name>.old first,
# and links that are already right are left alone. Installs no packages;
# it lists what's missing at the end.
set -eu

REPO=https://github.com/EnvyMeAdams/hyprland-dotfiles
ISLAND_REPO=https://github.com/EnvyMeAdams/quickshell-dotfiles
CONF="${XDG_CONFIG_HOME:-$HOME/.config}"
HYPR="$CONF/hypr"
island=1
for a in "$@"; do
	case "$a" in
	--no-island) island=0 ;;
	*) echo "Unknown option: $a" >&2; exit 2 ;;
	esac
done

say()  { printf '\033[1m==>\033[0m %s\n' "$*"; }
note() { printf '    %s\n' "$*"; }

[ "$(id -u)" -ne 0 ] || { echo "Run this as yourself, not as root." >&2; exit 1; }
command -v git >/dev/null || { echo "git is needed: doas emerge --ask dev-vcs/git" >&2; exit 1; }

# ── 1. the repo itself, at ~/.config/hypr ──
if [ -d "$HYPR/.git" ]; then
	say "Updating $HYPR"
	git -C "$HYPR" pull --ff-only || note "Couldn't fast-forward (local changes?). Leaving it as is."
else
	if [ -e "$HYPR" ]; then
		mv "$HYPR" "$HYPR.old-$(date +%Y%m%d-%H%M%S)"
		note "Moved your existing $HYPR aside"
	fi
	say "Cloning dotfiles into $HYPR"
	git clone "$REPO" "$HYPR"
fi

# ── 2. links ──
# link <file in repo> <where it goes>
link() {
	src="$HYPR/$1" dst="$2"
	mkdir -p "$(dirname "$dst")"
	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
		note "ok   ${dst#"$HOME"/}"
		return
	fi
	if [ -e "$dst" ] || [ -L "$dst" ]; then
		mv "$dst" "$dst.old"
		note "kept your old ${dst#"$HOME"/} as ${dst#"$HOME"/}.old"
	fi
	ln -s "$src" "$dst"
	note "link ${dst#"$HOME"/}"
}
say "Linking config files"
link kitty/kitty.conf       "$CONF/kitty/kitty.conf"
link ghostty/config         "$CONF/ghostty/config"
link fastfetch/config.jsonc "$CONF/fastfetch/config.jsonc"
link shell/bashrc           "$HOME/.bashrc"
link shell/bash_profile     "$HOME/.bash_profile"
mkdir -p "$CONF/fastfetch/logos"
chmod +x "$HYPR/xdg-portal-hyprland" "$HYPR/scripts/"* 2>/dev/null || true

# ── 3. superfile: wallpaper theme + see-through background ──
spf="$CONF/superfile/config.toml"
if [ -f "$spf" ]; then
	sed -i 's/^theme = .*/theme = "wallpaper"/; s/^transparent_background = .*/transparent_background = true/' "$spf"
	note "superfile set to the wallpaper theme"
elif command -v spf >/dev/null; then
	note "Open spf once (it makes its config), then run this again to theme it"
fi

# ── 4. the Quickshell island ──
if [ "$island" = 1 ]; then
	dir="$HOME/quickshell-dotfiles"
	if [ -d "$dir/.git" ]; then
		say "Updating the island ($dir)"
		git -C "$dir" pull --ff-only || note "Couldn't fast-forward the island repo. Leaving it."
	else
		say "Cloning the island into $dir"
		git clone "$ISLAND_REPO" "$dir"
	fi
	sh "$dir/install.sh" | sed 's/^/    /'
fi

# ── 5. colours from the wallpaper, once now (the login autostart keeps them current) ──
if python3 -c "import PIL" 2>/dev/null; then
	"$HYPR/scripts/wallpaper-colors" 2>/dev/null || note "No island wallpaper set yet; colours follow once you pick one"
fi

# ── 6. what's missing ──
say "Checking programs"
missing=""
need() {   # need <command> <package>
	command -v "$1" >/dev/null 2>&1 || missing="$missing $2"
}
need Hyprland gui-wm/hyprland
need quickshell gui-apps/quickshell
need kitty x11-terms/kitty
need spf app-misc/superfile
need fastfetch app-misc/fastfetch
need firefox www-client/firefox
need wpctl media-video/wireplumber
need playerctl media-sound/playerctl
need brightnessctl app-misc/brightnessctl
need hyprshot gui-apps/hyprshot
need ffmpegthumbnailer media-video/ffmpegthumbnailer
need syncthing net-p2p/syncthing
[ -x /usr/libexec/xdg-desktop-portal-hyprland ] || missing="$missing gui-libs/xdg-desktop-portal-hyprland"
[ -x /usr/libexec/xdg-desktop-portal-gtk ] || missing="$missing sys-apps/xdg-desktop-portal-gtk"
[ -x /usr/libexec/hyprpolkitagent ] || missing="$missing gui-apps/hyprpolkitagent"
python3 -c "import PIL" 2>/dev/null || missing="$missing dev-python/pillow"
if [ -n "$missing" ]; then
	note "Not installed:$missing"
	note "Install with: doas emerge --ask$missing"
	note "(superfile needs the guru repo and ~amd64; fastfetch image logos need USE=imagemagick)"
else
	note "Everything's installed"
fi

echo
say "Done. Next:"
note "Put fastfetch pictures in ~/.config/fastfetch/logos/"
note "Check config/monitors.lua matches this machine's screens"
[ "$island" = 1 ] && note "Login screen (optional): doas ~/quickshell-dotfiles/greeter/install.sh --enable"
note "Log out and back in (or reboot) to start everything"
