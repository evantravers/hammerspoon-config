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
--- bundleID and a set of rules following this pattern:
---
--- rules = {
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
---     rules = {
---       {"Meet - ", 2, hs.layout.maximized}
---     }
---   }
--- }

local module = {}
local fn = hs.fnutils

module.num_of_screens = 0

module.whichScreen = function(num)
  local displays = hs.screen.allScreens()
  if displays[num] ~= nil then
    return displays[num]
  else
    return hs.screen.primaryScreen()
  end
end

-- autoLayout() :: nil
-- Evaluates module.config and obeys the rules.
-- Includes any rules in module.config.layout as overrides.
module.autoLayout = function()
  local layouts = module.config.layouts

  if hs.settings.get('headspace') then
    local space = hs.fnutils.find(Config.spaces, function(s)
      return s.text == hs.settings.get('headspace').text
    end)

    if space and space.layouts then
      layouts = fn.concat(layouts, space.layouts)
    end
  end

  hs.layout.apply(layouts, string.match)
end

-- initialize watchers
module.start = function(config_table)
  module.config = config_table

  local layouts = {}
  fn.map(module.config.applications, function(app_config)
    local bundleID = app_config['bundleID']
    if app_config.rules then
      fn.map(app_config.rules, function(rule)
        local title_pattern, screen, layout = rule[1], rule[2], rule[3]
        table.insert(layouts,
          {
            hs.application.get(bundleID), -- application name
            title_pattern,                -- window title
            module.whichScreen(screen),   -- screen
            layout,                       -- layout
            nil,
            nil
          }
        )
      end)
    end
  end)

  module.config.layouts = layouts

  module.watcher = hs.screen.watcher.new(function()
    if module.num_of_screens ~= #hs.screen.allScreens() then
      module.autoLayout()
      module.num_of_screens = #hs.screen.allScreens()
    end
  end):start()
end

return module
