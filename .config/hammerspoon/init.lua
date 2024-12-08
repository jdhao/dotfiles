-- config for hammerspoon

-- require("./scripts/intput_source_switch")

hs.loadSpoon("InputSourceSwitch")

spoon.InputSourceSwitch:setApplications({
    ["WeChat"] = "Pinyin - Simplified",
    ["Raycast"] = "ABC",
    ["Google Chrome"] = "ABC",
    ["WezTerm"] = "ABC",
})

spoon.InputSourceSwitch:start()
