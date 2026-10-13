-- Session
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Cursor (Hyprcursor for Wayland apps, XCursor for X11/GTK fallbacks; same size)
hl.env("HYPRCURSOR_THEME", "volantes")
hl.env("HYPRCURSOR_SIZE", "28")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "28")

-- Icon theme used by Quickshell (app icons in the launcher, Alt+Tab, notifications).
-- Change to any theme installed in /usr/share/icons. Missing icons fall back to a letter badge.
hl.env("QS_ICON_THEME", "Papirus")
