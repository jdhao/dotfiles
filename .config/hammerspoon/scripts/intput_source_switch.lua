-- 当选中某窗口按下 ctrl+command+. 时会显示应用的路径、名字等信息
hs.hotkey.bind({ "ctrl", "cmd" }, ".", function()
  hs.pasteboard.setContents(hs.window.focusedWindow():application():path())
  hs.alert.show(
    "App path:        "
      .. hs.window.focusedWindow():application():path()
      .. "\n"
      .. "App name:      "
      .. hs.window.focusedWindow():application():name()
      .. "\n"
      .. "IM source id:  "
      .. hs.keycodes.currentSourceID(),
    hs.alert.defaultStyle,
    hs.screen.mainScreen(),
    3
  )
end)

-- 这里指定中文和英文输入法的 ID
local function Chinese()
  hs.keycodes.currentSourceID("com.apple.inputmethod.SCIM.ITABC")
end
local function English()
  hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

-- 指定程序
local appInputMethod = {
  ["Raycast"] = English,
  ["Google Chrome"] = English,
  ["WezTerm"] = English,
}

-- activated 时切换到指定的输入法，deactivated 时恢复之前的状态
currentID = ""
function applicationWatcher(appName, eventType, appObject)
  -- print(hs.inspect(appName))
  -- print(hs.inspect(eventType))
  -- print(hs.inspect(appObject))
  if eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched then
    for app, fn in pairs(appInputMethod) do
      if app == appName then
        currentID = hs.keycodes.currentSourceID()
        fn()
      end
    end
  end

  if eventType == hs.application.watcher.deactivated then
    for app, fn in pairs(appInputMethod) do
      if app == appName then
        hs.keycodes.currentSourceID(currentID)
        currentID = hs.keycodes.currentSourceID()
      end
    end
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher):start()

-- 输入法切换提示
-- hs.keycodes.inputSourceChanged(function()
--     if hs.keycodes.currentMethod() == nil then
--         hs.alert.show("ABC", hs.alert.defaultStyle, hs.screen.mainScreen(), 2)
--     else
--         hs.alert.show("拼音", hs.alert.defaultStyle, hs.screen.mainScreen(), 2)
--     end
-- end)
