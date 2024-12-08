-- config for hammerspoon

local hyper = { "alt", "ctrl", "cmd" }

require("scripts.intput_source_switch")
require("scripts.network")

hs.loadSpoon("SpoonInstall")

-- Show EmmyLua annotations for Hammerspoon itself and also for spoons
spoon.SpoonInstall:andUse("EmmyLua")

-- move current window between different monitors, source: https://stackoverflow.com/a/58662204/6064933
hs.hotkey.bind(hyper, 'n', function()
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0.2)
end)

-- reload config
hs.hotkey.bind(hyper, 'r', function()
  hs.console.clearConsole()
  hs.reload()
end)

-- Note that we need to enabel notficaton for Hammerspoon in system "notification" setting,
-- in oder to send notification below, otherwise, you see nothing.
hs.notify.show("Hammerspoon started", "", "")
