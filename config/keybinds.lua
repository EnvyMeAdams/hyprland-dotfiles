local programs = require("config.programs")
local mainMod = "SUPER"
local qs = "quickshell ipc call island "

-- Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(programs.browser))

-- Quickshell
hl.bind("ALT + Space",          hl.dsp.exec_cmd(qs .. "toggleLauncher"))
hl.bind("ALT + Tab",            hl.dsp.exec_cmd(qs .. "windows"))
hl.bind("ALT + SHIFT + Tab",    hl.dsp.exec_cmd(qs .. "windowsPrev"))
hl.bind("SUPER + N",            hl.dsp.exec_cmd(qs .. "toggleHub"))
hl.bind("SUPER + S",            hl.dsp.exec_cmd(qs .. "openTab search"))
hl.bind("SUPER + C",            hl.dsp.exec_cmd(qs .. "toggleControl"))
hl.bind("SUPER + L",            hl.dsp.exec_cmd(qs .. "lock"))
hl.bind("SUPER + D",            hl.dsp.exec_cmd(qs .. "dnd"))
hl.bind("SUPER + M",            hl.dsp.exec_cmd(qs .. "micmute"))
hl.bind("SUPER + SHIFT + B",    hl.dsp.exec_cmd(qs .. "nightlight"))
hl.bind("SUPER + SHIFT + S",    hl.dsp.exec_cmd(qs .. "screenshot region"))
hl.bind("SUPER + SHIFT + R",    hl.dsp.exec_cmd(qs .. "record"))

-- Session
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("CTRL + ALT + DELETE",  hl.dsp.exec_cmd("doas /sbin/reboot"))

-- Windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + F",         hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces: Super+1..9,0 switch; Super+Shift+number moves the active window
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse: move / resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots (hyprshot)
hl.bind(mainMod .. " + PRINT",           hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT",                 hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + PRINT",   hl.dsp.exec_cmd("hyprshot -m region"))

-- Media keys (work on the lock screen)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })
