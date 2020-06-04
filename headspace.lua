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
--   key = "example",
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
-- Warnings set up for launching apps not tagged properly.
-- timed sessions like a built-in Pomodoro to help box time.
-- Preset screens for working.
-- Musical cues?

local module = {}

local hyper  = require('hyper')
local hs_app = require('hs.application')
local fn     = require('hs.fnutils')
local util   = require('util')
local toggl  = require('toggl')

module.start = function()
  hyper:bind({}, 'l', nil, function()
    local chooser = hs.chooser.new(function(space)
      if space ~= nil then
        if not hs.eventtap.checkKeyboardModifiers()['shift'] then
          if space.toggl_proj then
            description = ""
            if space.toggl_desc then
              description = space.toggl_desc
            end
            toggl.start_timer(space.toggl_proj, description)
          end
        end

        if space.always then
          util.launch(space.always)
        end

        if space.never then
          util.kill(space.never)
        end

        if space.only then
          fn.map(config.applications, function(app)
            fn.map(hs.application.applicationsForBundleID(app.bundleID), function(a) a:kill() end)
          end)
          util.launch(space.only)
        end

        if config.setup[space.key] then
          config.setup[space.key]()
        end
      end
    end)

    chooser
      :placeholderText("Select a headspace…")
      :choices(config.spaces)
      :show()
  end)
end

return module
