-- HEADSPACE
--
-- You need in namespace a table at `config.spaces`.
-- `config.spaces` is a table that is passed to a chooser, but can take some
-- arguments based on what you want it to "never" open, "always" open, or
-- "only" open.
--
-- Optionally, you can define a setup function at config.spaces.<key> that is
-- run when the space is started.
--
-- # Example:
--
-- config.spaces = {
--   text = "Example",
--   subText = "More about the example",
--   image = hs.image.imageFromAppBundle('foo.bar.com'),
--   setup = "example",
--   always = {"table", "of", "#tags", "or" "bundleIDs"},
--   never = {"table", "of", "#tags", "or" "bundleIDs"},
--   only = {"table", "of", "#tags", "or" "bundleIDs"}
--   toggl_proj = "id of toggl project",
--   toggl_descr = "description of toggl timer
-- }
--
-- config.spaces.setup.example = function()
--   hs.urlevent.openURL("http://hammerspoon.org")
-- end
--
-- The goal is to get into another space, even when working from home.
--
-- Future expansions...
-- DND status?
-- Custom Desktop Background with prompts for focus, writing, code?
-- timed sessions like a built-in Pomodoro to help box time.
-- Preset screens for working.
-- Musical cues?

local module = {}

local fn     = require('hs.fnutils')
local brave  = require('brave')
local toggl  = require('toggl')

-- Expects a table with a key for "spaces" and a key for "setup".
module.start = function(config_table)
  module.config = config_table
end

module.choose = function()
  local chooser = hs.chooser.new(function(space)
    if space ~= nil then

      -- If not holding shift
      if not hs.eventtap.checkKeyboardModifiers()['shift'] then
        if space.toggl_proj or space.toggl_desc then
          local description = ""
          if space.toggl_desc then
            description = space.toggl_desc
          end
          toggl.start_timer(space.toggl_proj, description)
        end
      end

      if space.always then
        module.launch(space.always)
        brave.launch(space.always)
      end

      if space.never then
        hs.settings.set("never", space.never)
        module.kill(space.never)
        brave.kill(space.never)
      else
        hs.settings.clear("never")
      end

      if space.only then
        fn.map(module.config.applications, function(app)
          fn.map(hs.application.applicationsForBundleID(app.bundleID), function(a) a:kill() end)
        end)
        hs.settings.set("only", space.only)
        module.launch(space.only)
        brave.launch(space.only)
      else
        hs.settings.clear("only")
      end

      if module.config.setup[space.setup] then
        module.config.setup[space.setup]()
      end
    end
  end)

  chooser
    :placeholderText("Select a headspace…")
    :choices(module.config.spaces)
    :queryChangedCallback(function(searchQuery)
      local query = string.lower(searchQuery)
      local results = fn.filter(module.config.spaces, function(space)
        local text = string.lower(space.text)
        local subText = string.lower(space.subText)
        return (string.match(text, query) or string.match(subText, query))
      end)

      table.insert(results, {
        text = searchQuery,
        subText = "Start a toggl timer with this description...",
        image = hs.image.imageFromAppBundle('com.toggl.toggldesktop.TogglDesktop'),
        toggl_desc = searchQuery
      })

      chooser:choices(results)
    end)
    :showCallback(function()
      local current = toggl.current_timer()
      if current and current.data then
        local timer = current.data
        local str = "🔴 :"
        if timer.description then
          str = str .. " " .. timer.description
        end
        if timer.pid then
          local project = toggl.get_project(timer.pid)
          if project and project.data then
            str = str .. " ("  .. project.data.name .. ")"
          end
        end
        local duration = math.floor((hs.timer.secondsSinceEpoch() + current.data.duration) / 60) .. "m"
        chooser:placeholderText(str .. " :: " .. duration)
      end
    end)
    :show()
end

module.choose_timer = function()
  local ok, input = hs.dialog.textPrompt(
    "how long?",
    "Set up a timed HeadSpace"
  )
end

module.appsTaggedWith = function(tag)
  return hs.fnutils.filter(module.config.applications, function(app)
    return app.tags and hs.fnutils.contains(app.tags, tag)
  end)
end

-- launches either by tag or by bundle id from a list
module.launch = function(list)
  hs.fnutils.map(list, function(tag)
    hs.fnutils.map(module.appsTaggedWith(tag), function(app)
      hs.application.launchOrFocusByBundleID(app.bundleID)
    end)
  end)
end

module.kill = function(list)
  hs.fnutils.map(list, function(tag)
    hs.fnutils.map(module.appsTaggedWith(tag), function(app)
      hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
        app:kill()
      end)
    end)
  end)
end

return module
