local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "hyprlauncher"
local browser = "brave"

------------------
---- KEYBINDS ----
------------------

hl.bind("SUPER + Q", hl.dsp.window.kill())
hl.bind("SUPER + Space", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + N", hl.dsp.exec_cmd(fileManager))

-- Stato finestre
hl.bind("ALT + Return", hl.dsp.window.fullscreen())
hl.bind("ALT + SHIFT + Return", hl.dsp.window.float({ action = "toggle" }))

------------------
----  FOCUS   ----
------------------

hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)
-- hl.bind("ALT + SHIFT + Tab", hl.dsp.window.focus("l")) ??
