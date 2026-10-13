-- DP-2: workspaces 1-5, HDMI-A-1: workspaces 6-10
for ws = 1, 10 do
    local first = (ws == 1 or ws == 6)
    hl.workspace_rule({
        workspace = tostring(ws),
        monitor   = ws <= 5 and "DP-2" or "HDMI-A-1",
        default   = first or nil,
    })
end
