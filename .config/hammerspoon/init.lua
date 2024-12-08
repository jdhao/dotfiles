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

-- Note that we need to enabel notficaton for Hammerspoon in system "notification" setting,
-- in oder to send notification below, otherwise, you see nothing.
hs.notify.show("Hammerspoon started", "", "")
