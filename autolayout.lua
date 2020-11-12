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
-- bundleID and a set of rules following this pattern:
--
-- rules = {
--   {
--     <window title string or nil>,
--     <int of preferred monitor>,
--     <layout from hs.layout>
--   }
-- }
--
-- Example:
-- config.applications = {
--   ['com.brave.Browser'] = {
--     bundleID = 'com.brave.Browser',
--     rules = {
--       {"Meet - ", 2, hs.layout.maximized}
--     }
--   }
-- }

local autolayout = {}
local fn = hs.fnutils

autolayout.num_of_screens = 0

autolayout.screen = function(num)
  local displays = hs.screen.allScreens()
  if displays[num] ~= nil then
    return displays[num]
  else
    return hs.screen.primaryScreen()
  end
end

-- autolayout() :: nil
-- evaluates autolayout.config and obeys the rules.
autolayout.autoLayout = function()
  local layouts = {}
  fn.map(autolayout.config.applications, function(app_config)
    local bundleID = app_config['bundleID']
    if app_config.rules then
      fn.map(app_config.rules, function(rule)
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
      end)
    end
  end)

  hs.layout.apply(layouts)
end

-- initialize watchers
autolayout.start = function(config_table)
  autolayout.config = config_table

  autolayout.watcher = hs.screen.watcher.new(function()
    if autolayout.num_of_screens ~= #hs.screen.allScreens() then
      autolayout.autoLayout()
      autolayout.num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

return autolayout
