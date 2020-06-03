-- The goal is to get into another space, even when working from home.

-- Custom Desktop Background with prompts for focus, writing, code?
-- DND status?
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

module.spaces = {
  {
    text = "Review",
    subText = "Setup a Things 3 Review Session",
    image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
    key = 'review',
    toggl_proj = config.projects.planning,
    toggl_desc = "Review",
    never = {'#communication', '#distraction'},
  },
  {
    text = "Plan a Focus Budget",
    subText = "Setup Things 3 and Fantastical",
    image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
    key = 'focus_budget',
    never = {'#communication', '#distraction'},
    toggl_proj = config.projects.planning,
    toggl_desc = "Focus Budget",
  },
  {
    text = "Communicate",
    subText = "Intentionally engage with Slack and Email",
    image = hs.image.imageFromAppBundle('com.tinyspeck.slackmacgap'),
    key = "communicate",
    always = {'#communication'},
    toggl_proj = config.projects.communications
  },
  {
    text = "Meetings",
    subText = "Collaborating and catching up.",
    image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
    key = "meetings",
    never = {'#distraction'},
    always = {'com.flexibits.fantastical2.mac'},
    toggl_proj = config.projects.meetings,
  },
  {
    text = "Write",
    subText = "You are allowed to do anything you want, as long as you write.",
    image = hs.image.imageFromAppBundle('com.agiletortoise.Drafts-OSX'),
    key = "write",
    only = {'#writing'}
  },
  {
    text = "Design",
    subText = "Iterating and collaborating on Design artifacts in Figma",
    image = hs.image.imageFromAppBundle('com.figma.Desktop'),
    key = "design",
    only = {'#design'},
    toggl_proj = config.projects.design
  },
  {
    text = "UX Research",
    subText = "Engaged in uninterrupted user research",
    image = hs.image.imageFromAppBundle('com.ideasoncanvas.mindnode.macos'),
    key = "research",
    only = {'#research'},
    toggl_proj = config.projects.research
  },
  {
    text = "Standup",
    subText = "Run UX Standup",
    image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
    key = "standup",
    always = {'#planning'},
    never = {'#distraction', '#communication', '#coding'},
    toggl_proj = config.projects.meetings,
    toggl_desc = "UX Standup"
  }
}

module.setup = {}

module.setup.review = function()
  hs_app.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
  local things = hs_app.find('com.culturedcode.ThingsMac')

  fn.imap(things:allWindows(), function(v) v:close() end)

  things:selectMenuItem("New Things Window")

  things:selectMenuItem("Hide Sidebar")
  things:selectMenuItem("Today")
  things:selectMenuItem("New Things Window")

  things:selectMenuItem("Show Sidebar")
  things:selectMenuItem("Anytime")

  hs.layout.apply(
    {
      {"Things", "Anytime", hs.screen.primaryScreen(), hs.layout.left70, 0, 0},
      {"Things", "Today", hs.screen.primaryScreen(), hs.layout.right30, 0, 0}
    }
  )
end

module.setup.focus_budget = function()
  hs_app.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
  hs_app.launchOrFocusByBundleID('com.flexibits.fantastical2.mac')

  local things = hs_app.find('com.culturedcode.ThingsMac')
  local fantastical = hs_app.find('com.flexibits.fantastical2.mac')

  local today = things:focusedWindow()
  today:application():selectMenuItem("Hide Sidebar")
  today:application():selectMenuItem("Today")

  local cal = fantastical:focusedWindow()
  cal:application():selectMenuItem("Hide Sidebar")
  cal:application():selectMenuItem("By Week")

  hs.layout.apply(
    {
      {"Fantastical", nil, hs.screen.primaryScreen(), hs.layout.left70, 0, 0},
      {"Things", "Today", hs.screen.primaryScreen(), hs.layout.right30, 0, 0}
    }
  )
end

module.setup.standup = function()
  hs.urlevent.openURL(hs.settings.get("standupURL"))
  hs.urlevent.openURL(hs.settings.get("standupCall"))
end

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

        if module.setup[space.key] then
          module.setup[space.key]()
        end
      end
    end)

    chooser
      :placeholderText("Select a headspace…")
      :choices(module.spaces)
      :show()
  end)
end

return module
