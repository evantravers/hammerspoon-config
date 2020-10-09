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
--   ['com.brave.Browser'] = {
--     bundleID = 'com.brave.Browser',
--     preferred_display = 1
--   }
-- }

local autolayout = {}

autolayout.num_of_screens = 0

autolayout.screen = function(num)
  local displays = hs.screen.allScreens()
  if displays[displays_int] ~= nil then
    return displays[displays_int]
  else
    return hs.screen.primaryScreen()
  end
end

-- autolayout() :: nil
-- evaluates autolayout.config and obeys the rules.
autolayout.autoLayout = function()
  local layouts = {}
  for _, app_config in pairs(module.config.applications) do
    local bundleID = app_config['bundleID']
    if app_config.rules then
      for _, rule in pairs(app_config.rules) do
        local title_pattern, screen, layout = rule[1], rule[2], rule[3]
        table.insert(layouts,
          {
            hs.application.get(bundleID),  -- application name
            hs.window.find(title_pattern), -- window title
            autolayout.screen(screen),     -- window title
            layout,                        -- layout
            nil,
            nil
          }
        )
      end
    end
  end
  hs.layout.apply(layouts)
end

-- initialize watchers
autolayout.start = function(config_table)
  module.config = config_table

  autolayout.watcher = hs.screen.watcher.new(function()
    if autolayout.num_of_screens ~= #hs.screen.allScreens() then
      autolayout.autoLayout()
      autolayout.num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

return autolayout
