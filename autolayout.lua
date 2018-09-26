target_display = function(display_int)
  -- detect the current number of monitors
  displays = hs.screen.allScreens()
  if displays[display_int] ~= nil then
    return displays[display_int]
  else
    return hs.screen.primaryScreen()
  end
end

autoLayout = function()
  for _, app_config in pairs(config.applications) do
    -- if we have a preferred display
    if app_config.preferred_display ~= nil then
      application = hs.application.find(app_config.name)

      if application ~= nil then
        application
        :mainWindow()
        :moveToScreen(target_display(app_config.preferred_display), false, true, 0)
        :moveToUnit(hs.layout.maximized)
      end
    end
  end
end
