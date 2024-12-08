-- config for hammerspoon

-- require("./scripts/intput_source_switch")

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("InputSourceSwitch")

spoon.InputSourceSwitch:setApplications({
    ["WeChat"] = "Pinyin - Simplified",
    ["Telegram"] = "Pinyin - Simplified",
    ["Raycast"] = "ABC",
    ["Google Chrome"] = "ABC",
    ["WezTerm"] = "ABC",
})

spoon.InputSourceSwitch:start()

-- Show EmmyLua annotations for Hammerspoon itself and also for spoons
spoon.SpoonInstall:andUse("EmmyLua")


-- move current window between different monitors
hs.hotkey.bind({'alt', 'ctrl', 'cmd'}, 'n', function()
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- Note that we need to enabel notficaton for Hammerspoon in system "notification" setting,
-- in oder to send notification below, otherwise, you see nothing.
hs.notify.show("Hammerspoon started", "", "")
