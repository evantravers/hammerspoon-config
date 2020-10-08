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
-- But if you need more than one monitor and another default layout than maximized,
-- this script also got you covered.
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
--     preferred_display = 1,
--     preferred_layout = 'left'
--   }
-- }


-- predefine some layout for windows
local window_layout_preset = {
  ['left'] = hs.layout.left50,
  ['right'] = hs.layout.right50,
  ['top'] = {0,0,1,0.5},
  ['bot'] = {0,0.5,1,0.5},
  ['max'] = hs.layout.maximized
}

local autolayout = {}

autolayout.num_of_screens = 0

-- target_display(int) :: hs.screen
-- detect the current number of monitors
autolayout.target_display = function(display_int)
  local displays = hs.screen.allScreens()
  if displays[display_int] ~= nil then
    return displays[display_int]
  else
    return hs.screen.primaryScreen()
  end
end

-- autolayout() :: nil
-- evaluates module.config and obeys the rules.
autolayout.autoLayout = function()
  local layout = {}
  for _, app_config in pairs(module.config.applications) do
    print(app_config.bundleID)
    if app_config.preferred_display then
      table.insert(
        layout,
        {
          app_config.bundleID,
          nil,
          autolayout.target_display(app_config.preferred_display),
          (window_layout_preset[app_config.preferred_layout] or hs.layout.maximized),
          nil,
          nil
        }
      )
    end
  end
  hs.layout.apply(layout)
end

-- initialize watchers
autolayout.start = function(config_table)
  module.config = config_table

  module.watcher = hs.screen.watcher.new(function()
    if module.num_of_screens ~= #hs.screen.allScreens() then
      autolayout.autoLayout()
      module.num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

return autolayout
