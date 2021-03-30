--- === AUTOLAYOUT ===
---
--- This is largely stolen from @megalithic's epic work. This lets application's
--- windows automatically re-settle depending on whether I'm on a single laptop
--- or a dock with an external (and now primary) monitor.
---
--- I prefer applications full screened (for the most part, so this is
--- simplified. I also don't roll with more than two monitors, but this should
--- scale theoretically.
---
--- When you start it, it starts the watcher. You can also trigger an autolayout
--- by calling module.autoLayout()
---
--- Expects a table with a key for `applications` with sub-tables with a
--- bundleID and a set of layouts following this pattern:
---
--- layouts = {
---   {
---     <window title string or nil>,
---     <int of preferred monitor>,
---     <layout from hs.layout>
---   }
--- }
---
--- Example:
--- config.applications = {
---   ['com.brave.Browser'] = {
---     bundleID = 'com.brave.Browser',
---     layouts = {
---       {"Meet - ", 2, hs.layout.maximized}
---     }
---   }
--- }

local m = {}
local fn = hs.fnutils
m.num_of_screens = 0
m.whichScreen = function(num)
  local displays = hs.screen.allScreens()
  if displays[num] ~= nil then
    return displays[num]
  else
    return hs.screen.primaryScreen()
  end
end

-- autoLayout() :: nil
-- Evaluates module.config and obeys the layouts.
-- Includes any layouts in module.config.layout as overrides.
m.autoLayout = function()
  local space = nil
  if hs.settings.get('headspace') then
    space = hs.fnutils.find(Config.spaces, function(s)
      return s.text == hs.settings.get('headspace').text
    end)
  end

  if space and space.layouts then
    hs.layout.apply(fn.concat(m.config.layouts, space.layouts), string.match)
  else
    hs.layout.apply(m.config.layouts, string.match)
  end
end

-- initialize watchers
m.start = function(config_table)
  m.config = config_table

  local layouts = {}
  fn.map(m.config.applications, function(app_config)
    local bundleID = app_config['bundleID']
    if app_config.layouts then
      fn.map(app_config.layouts, function(rule)
        local title_pattern, screen, layout = rule[1], rule[2], rule[3]
        table.insert(layouts,
          {
            hs.application.get(bundleID), -- application name
            title_pattern,                -- window title
            m.whichScreen(screen),        -- screen
            layout,                       -- layout
            nil,
            nil
          }
        )
      end)
    end
  end)

  m.config.layouts = layouts

  m.watcher = hs.screen.watcher.new(function()
    if m.num_of_screens ~= #hs.screen.allScreens() then
      m.autoLayout()
      m.num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

return m
