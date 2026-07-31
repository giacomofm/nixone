---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "nautilus"
local browser     = "brave"
local menu        = "hyprlauncher"

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind("SUPER + Space", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + Q", hl.dsp.window.kill())
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + N", hl.dsp.exec_cmd(fileManager))

-- Stato finestre
hl.bind("ALT + Return",         hl.dsp.window.fullscreen())
hl.bind("ALT + SHIFT + Return", hl.dsp.window.float({ action = "toggle" }))

---- FOCUS
hl.bind("SUPER + up",    hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down",  hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + left",  hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
-- Scroll through existing workspaces with mainMod + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = { 
        gaps_out = 10,
        layout = "master",
    },
    master = { orientation = "left" },
})
hl.bind("SUPER + M", hl.dsp.layout("swapwithmaster master"))

---- CURSOR
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "26")
