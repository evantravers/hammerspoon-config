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

module.choices = {
  {
    text = "Review",
    subText = "Setup a Things 3 Review Session",
    key = 'review',
    image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac')
  },
  {
    text = "Plan a Focus Budget",
    subText = "Setup Things 3 and Fantastical",
    key = 'focus_budget',
    image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac')
  },
  {
    text = "Communicate",
    subText = "Intentionally engage with Slack and Email",
    key = "communicate",
    image = hs.image.imageFromAppBundle('com.tinyspeck.slackmacgap')
  },
  {
    text = "Meetings",
    subText = "Collaborating and catching up.",
    key = "meetings",
    image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac')
  },
  {
    text = "Write",
    subText = "You are allowed to do anything you want, as long as you write.",
    key = "write",
    image = hs.image.imageFromAppBundle('com.agiletortoise.Drafts-OSX')
  },
  {
    text = "Design",
    subText = "Iterating and collaborating on Design artifacts in Figma",
    key = "design",
    image = hs.image.imageFromAppBundle('com.figma.Desktop')
  },
  {
    text = "UX Research",
    subText = "Engaged in uninterrupted user research",
    key = "research",
    image = hs.image.imageFromAppBundle('com.ideasoncanvas.mindnode.macos')
  }
}

-- Each space gets a key related to the keys above
-- always launches by tag, or bundle name
-- setup() is a function run automatically if it exists
module.spaces = {
  ['review'] = {
    toggl_proj = config.projects.planning,
    toggl_desc = "Review",
    never = {'#communication', '#distraction'},
    setup = function()
      hs_app.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
      local things = hs_app.find('com.culturedcode.ThingsMac')

      fn.imap(things:allWindows(), function(v) v:close() end)
      things:selectMenuItem("New Things Window")

      local today = things:allWindows()[1]
      today:focus()
      today:moveToUnit(hs.layout.right30)
      today:application():selectMenuItem("Hide Sidebar")
      today:application():selectMenuItem("Today")
      today:application():selectMenuItem("New Things Window")

      local workspace = fn.ifilter(things:allWindows(), function(w)
        if today == w then
          return false
        else
          return true
        end
      end)[1]

      workspace:focus()
      workspace:moveToUnit(hs.layout.left70)
      workspace:application():selectMenuItem("Show Sidebar")
      workspace:application():selectMenuItem("Anytime")
    end
  },
  ["focus_budget"] = {
    never = {'#communication', '#distraction'},
    toggl_proj = config.projects.planning,
    toggl_desc = "Focus Budget",
    setup = function()
      hs_app.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
      hs_app.launchOrFocusByBundleID('com.flexibits.fantastical2.mac')

      local things = hs_app.find('com.culturedcode.ThingsMac')
      local fantastical = hs_app.find('com.flexibits.fantastical2.mac')

      local today = things:focusedWindow()
      today:moveToUnit(hs.layout.right30)
      today:application():selectMenuItem("Hide Sidebar")
      today:application():selectMenuItem("Today")

      local cal = fantastical:focusedWindow()
      cal:moveToUnit(hs.layout.left70)
      cal:application():selectMenuItem("Hide Sidebar")
      cal:application():selectMenuItem("By Week")
    end
  },
  ['communicate'] = {
    always = {'#communication'},
    toggl_proj = config.projects.communications
  },
  ['meetings'] = {
    never = {'#distraction'},
    always = {'com.flexibits.fantastical2.mac'},
    toggl_proj = config.projects.meetings,
    setup = function()
      -- turn on DND mode
      -- focus the meeting tab if it exists
      -- close distractions?
    end
  },
  ['write'] = {
    only = {'#writing'}
  },
  ['design'] = {
    only = {'#design'},
    toggl_proj = config.projects.design
  },
  ['research'] = {
    only = {'#research'},
    toggl_proj = config.projects.research
  }
}

module.start = function()
  hyper:bind({}, 'l', nil, function()
    local chooser = hs.chooser.new(function(choice)
      if choice ~= nil then
        local space = module.spaces[choice['key']]

        if space.toggl_proj then
          description = ""
          if space.toggl_desc then
            description = space.toggl_desc
          end
          toggl.start_timer(space.toggl_proj, description)
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

        if space.setup then
          space.setup()
        end
      end
    end)

    chooser:choices(module.choices)
    chooser:show()
  end)
end

return module
