local autolayout = {}

autolayout.num_of_screens = 0

autolayout.target_display = function(display_int)
  -- detect the current number of monitors
  displays = hs.screen.allScreens()
  if displays[display_int] ~= nil then
    return displays[display_int]
  else
    return hs.screen.primaryScreen()
  end
end

autolayout.autoLayout = function()
  for _, app_config in pairs(config.applications) do
    -- if we have a preferred display
    if app_config.preferred_display ~= nil then
      application = hs.application.find(app_config.bundleID)

      if application ~= nil and application:mainWindow() ~= nil then
        application
        :mainWindow()
        :moveToScreen(autolayout.target_display(app_config.preferred_display), false, true, 0)
        :moveToUnit(hs.layout.maximized)
      end
    end
  end
end

-- initialize watchers
autolayout.start = function ()
  local hyper = require("hyper")
  hs.screen.watcher.new(function()
    if num_of_screens ~= #hs.screen.allScreens() then
      autolayout.autoLayout()
      num_of_screens = #hs.screen.allScreens()
    end
  end):start()
  hyper:bind({}, 'return', nil, autolayout.autoLayout)
end

return autolayout
