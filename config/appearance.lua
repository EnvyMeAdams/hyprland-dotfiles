-- Gaps: gaps_out is uniform. The extra space under the Dynamic Island is added by
-- Quickshell (a layer-shell reservation) only on the monitor you are using, so
-- do NOT enlarge the top gap here.
-- Border colours live in hyprland-gui.lua (HyprMod owns the active border).
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
        col = {
            inactive_border = "rgba(595959aa)",
        },
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})
