-- Monitors. Quickshell's Display settings rewrite this file.
-- DP-2 = workspaces 1-5, HDMI-A-1 = workspaces 6-10 (rotated).
hl.monitor({
    output    = "DP-2",
    mode      = "1920x1080@180",
    position  = "0x0",
    scale     = 1,
    transform = 0,
})

hl.monitor({
    output    = "HDMI-A-1",
    mode      = "1920x1080@100",
    position  = "1920x0",
    scale     = 1,
    transform = 3,
})
