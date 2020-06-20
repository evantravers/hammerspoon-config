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

local store_settings = function(space)
  hs.settings.set("headspace", {
    text = space.text,
    always = space.always,
    never = space.never,
    only = space.only
  })
end

module.choose = function()
  local chooser = hs.chooser.new(function(space)
    if space ~= nil then
      store_settings(space)

      -- If not holding shift
      if not hs.eventtap.checkKeyboardModifiers()['shift'] then
        if space.toggl_proj or space.toggl_desc then
          toggl.start_timer(space.toggl_proj, space.toggl_desc)
        end
      end

      if space.always then
        module.launch(space.always)
        brave.launch(space.always)
      end

      if space.never then
        module.kill(space.never)
        brave.kill(space.never)
      end

      if space.only then
        module.only(space.only)
        brave.launch(space.only)
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
      local descr     = ""
      local proj      = ""
      local space_str = ""
      local toggl_str = ""

      local space = hs.settings.get("headspace")
      if space then
        space_str = "🔘: " .. space.text .. " "
      end

      local current = toggl.current_timer()
      if current and current.data then
        local timer = current.data

        if timer.description then
          descr = "💬: " .. timer.description .. " "

          if timer.description == space.text then -- we've got a custom timer
            space_str = ""
          end
        end

        if timer.pid then
          local project = toggl.get_project(timer.pid)
          if project and project.data then
            proj = "📂: "  .. project.data.name .. " "
          end
        end

        local duration = math.floor((hs.timer.secondsSinceEpoch() + current.data.duration) / 60) .. "m"

        toggl_str = proj .. descr
      end

      if toggl_str ~= "" or space_str ~= "" then
        chooser:placeholderText(space_str .. toggl_str)
      end
    end)
    :show()
end

module.appsTaggedWith = function(tag)
  return fn.filter(module.config.applications, function(app)
    return app.tags and fn.contains(app.tags, tag)
  end)
end

-- launches either by tag or by bundle id from a list
module.launch = function(list)
  fn.map(list, function(tag)
    fn.map(module.appsTaggedWith(tag), function(app)
      hs.application.launchOrFocusByBundleID(app.bundleID)
    end)
  end)
end

module.kill = function(list)
  fn.map(list, function(tag)
    fn.map(module.appsTaggedWith(tag), function(app)
      fn.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
        app:kill()
      end)
    end)
  end)
end

module.only = function(list)
  local protected = {}
  fn.map(list, function(tag)
    fn.map(module.appsTaggedWith(tag), function(app)
      table.insert(protected, app)
    end)
  end)

  fn.map(module.config.applications, function(app)
    if not fn.contains(protected, app) then
      fn.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
        app:kill()
      end)
    end
  end)
end

return module
