-- AUTOLAYOUT
--
-- This is largely stolen from @megalithic's epic work. This lets application's
-- windows automatically re-settle depending on whether I'm on a single laptop
-- or a dock with an external (and now primary) monitor.
--
-- I prefer applications full screened (for the most part, so this is
-- simplified. I also don't roll with more than two monitors, but this should
-- scale theoretically.
--
-- When you start it, it starts the watcher. You can also trigger an autolayout
-- by calling autolayout.autolayout()
--
-- Expects a table with a key for `applications` with sub-tables with a
-- bundleID and preferred_display:
--
-- Example:
-- config.applications = {
--   ['com.brave.browser'] = {
--     bundleID = 'com.brave.browser',
--     preferred_display = 1
--   }
-- }

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
  for _, app_config in pairs(module.config.applications) do
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
autolayout.start = function(config_table)
  module.config = config_table

  hs.screen.watcher.new(function()
    if num_of_screens ~= #hs.screen.allScreens() then
      autolayout.autoLayout()
      num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

return autolayout
