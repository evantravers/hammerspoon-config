config = {}

config.applications = {
  ['com.runningwithcrayons.Alfred'] = {
    bundleID = 'com.runningwithcrayons.Alfred',
    local_bindings = {'c', 'space', 'o'}
  },
  ['net.kovidgoyal.kitty'] = {
    bundleID = 'net.kovidgoyal.kitty',
    hyper_key = 'j',
    preferred_display = 1,
    tags = {'#coding'}
  },
  ['com.brave.browser'] = {
    bundleID = 'com.brave.browser',
    hyper_key = 'k',
    preferred_display = 1,
    tags = {'#coding'}
  },
  ['org.mozilla.firefox'] = {
    bundleID = 'org.mozilla.firefox',
    hyper_key = 'b',
    preferred_display = 1
  },
  ['com.kapeli.dashdoc'] = {
    bundleID = 'com.kapeli.dashdoc',
    hyper_key = 'h',
    tags = {'#coding'}
  },
  ['com.tinyspeck.slackmacgap'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    hyper_key = 'i',
    preferred_display = 2,
    tags = {'#distraction', '#communication'}
  },
  ['com.readdle.smartemail-Mac'] = {
    bundleID = 'com.readdle.smartemail-Mac',
    hyper_key = 'e',
    preferred_display = 2,
    tags = {'#distraction', '#communication'}
  },
  ['com.flexibits.fantastical2.mac'] = {
    bundleID = 'com.flexibits.fantastical2.mac',
    hyper_key = 'y',
    local_bindings = {']'},
    tags = {'#planning', '#review'},
    preferred_display = 2,
  },
  ['com.apple.finder'] = {
    bundleID = 'com.apple.finder',
    hyper_key = 'f'
  },
  ['com.hnc.Discord'] = {
    bundleID = 'com.hnc.Discord',
    preferred_display = 2,
    tags = {'#distraction'}
  },
  ['com.tapbots.Tweetbot3Mac'] = {
    bundleID = 'com.tapbots.Tweetbot3Mac',
    tags = {'#distraction', '#socialmedia'},
    local_bindings = {'\\'}
  },
  ['com.culturedcode.ThingsMac'] = {
    bundleID = 'com.culturedcode.ThingsMac',
    hyper_key = 't',
    preferred_display = 1,
    tags = {'#planning', '#review'},
    local_bindings = {',', '.'}
  },
  ['com.agiletortoise.Drafts-OSX'] = {
    bundleID = 'com.agiletortoise.Drafts-OSX',
    hyper_key ='d',
    tags = {'#review', '#writing', '#research'},
    local_bindings = {'x', ';'}
  },
  ['com.toggl.toggldesktop.TogglDesktop'] = {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    local_bindings = {'p'}
  },
  ['com.ideasoncanvas.mindnode.macos'] = {
    bundleID = 'com.ideasoncanvas.mindnode.macos',
    tags = {'#research', '#focusaid'},
    hyper_key = 'u',
    preferred_display = 1
  },
  ['com.apple.iChat'] = {
    bundleID = 'com.apple.iChat',
    hyper_key = 'q',
    tags = {'#communication', '#distraction'}
  },
  ['com.valvesoftware.steam'] = {
    bundleID = 'com.valvesoftware.steam',
    tags = {'#distraction'}
  },
  ['com.spotify.client'] = {
    bundleID = 'com.spotify.client',
    tags = {'#focusaid'}
  },
  ['com.figma.Desktop'] = {
    bundleID = 'com.figma.Desktop',
    tags = {'#design'}
  }
}

config.websites = {
  ['twitter.com'] = {
    url = 'twitter.com',
    tags = {'#distraction', '#socialmedia'}
  },
  ['instagram.com'] = {
    url = 'instagram.com',
    tags = {'#distraction', '#socialmedia'}
  },
  ['reddit.com'] = {
    url = 'reddit.com',
    tags = {'#distraction'}
  },
  ['instapaper.com'] = {
    url = 'instapaper.com',
    tags = {'#distraction', '#reading'}
  }
}

config.projects = {
  communications = "160553883",
  meetings       = "160775332",
  planning       = "160831759",
  reading        = "160934258",
  design         = "160553877",
  research       = "160553882"
}

config.spaces = {
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
    only = {'#writing', '#focusaid'}
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
config.setup = {}

config.setup.review = function()
  hs.application.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
  local things = hs.application.find('com.culturedcode.ThingsMac')
  things:selectMenuItem("Hide Sidebar")

  hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
  things:selectMenuItem("New Things Window")
  things:selectMenuItem("Today")

  things:selectMenuItem("New Things Window")
  if things:findMenuItem("Show Sidebar") then
    things:selectMenuItem("Show Sidebar")
  end
  things:selectMenuItem("Anytime")

  hs.layout.apply(
    {
      {"Things", "Anytime", hs.screen.primaryScreen(), hs.layout.left70, 0, 0},
      {"Things", "Today", hs.screen.primaryScreen(), hs.layout.right30, 0, 0}
    }
  )
end

config.setup.focus_budget = function()
  hs.application.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
  hs.application.launchOrFocusByBundleID('com.flexibits.fantastical2.mac')

  local things = hs.application.find('com.culturedcode.ThingsMac')
  local fantastical = hs.application.find('com.flexibits.fantastical2.mac')

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

config.setup.standup = function()
  hs.urlevent.openURL(hs.settings.get("standupURL"))
  hs.urlevent.openURL(hs.settings.get("standupCall"))
end

hyper = require 'hyper'
hyper.start()
movewindows = require 'movewindows'
movewindows.start()

local autolayout = require 'autolayout'
      autolayout.start()
      hyper:bind({}, 'return', nil, autolayout.autoLayout)

local airpods = require 'airpods'

local brave = require 'brave'

local headspace = require 'headspace'
      headspace.start()

local toggl = require('toggl')

local secrets = require('secrets')
      secrets.start()

hyper:bind({}, 'r', nil, function() hs.reload() end)

hyper:bind({}, 'a', nil, function()
  local ok, output = airpods.toggle('Evan’s AirPods')
  if ok then
    hs.alert.show(output)
  else
    hs.alert.show("Couldn't connect to AirPods!")
  end
end)

-- Jump to google hangout or zoom
hyper:bind({}, 'z', nil, function()
  if hs.application.find('us.zoom.xos') then
    hs.application.launchOrFocusByBundleID('us.zoom.xos')
  else
    brave.jump("meet.google.com|hangouts.google.com.call")
  end
end)

-- Jump to figma
hyper:bind({}, 'v', nil, function()
  if hs.application.find('com.figma.Desktop') then
    hs.application.launchOrFocusByBundleID('com.figma.Desktop')
  else
    brave.jump("lucidchart.com|figma.com")
  end
end)

-- Snip current highlight in Brave
hyper:bind({}, 's', nil, function()
  hs.osascript.applescript([[
    -- stolen from: https://gist.github.com/gabeanzelini/1931128eb233b0da8f51a8d165b418fa

    if (count of theSelectionFromBrave()) is greater than 0 then
      set str to "tags: #link\n\n" & theTitleFromBrave() & "\n\n> " & theSelectionFromBrave() & "\n\n[" & theTitleFromBrave() & "](" & theCurrentUrlInBrave() & ")"

      tell application "Drafts"
        make new draft with properties {content:str, tags: {"link"}}
      end tell
    end if


    on theCurrentUrlInBrave()
      tell application "Brave Browser" to get the URL of the active tab in the first window
    end theCurrentUrlInBrave

    on theSelectionFromBrave()
      tell application "Brave Browser" to execute front window's active tab javascript "getSelection().toString();"
    end theSelectionFromBrave

    on theTitleFromBrave()
      tell application "Brave Browser" to get the title of the active tab in the first window
    end theTitleFromBrave
  ]])
  hs.notify.show("Snipped!", "The snippet has been sent to Drafts", "")
end)
