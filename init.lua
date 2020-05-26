config = {}

config.applications = {
  ['com.runningwithcrayons.Alfred'] = {
    bundleID = 'com.runningwithcrayons.Alfred',
    local_bindings = {'c', 'space', 'o', 's'}
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
  ['com.apple.mail'] = {
    bundleID = 'com.apple.mail',
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
    tags = {'#review', '#writing'},
    local_bindings = {'x', ';'}
  },
  ['com.toggl.toggldesktop.TogglDesktop'] = {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    local_bindings = {'p'}
  },
  ['com.ideasoncanvas.mindnode.macos'] = {
    bundleID = 'com.ideasoncanvas.mindnode.macos',
    hyper_key = 'u',
    preferred_display = 1
  },
  ['com.apple.iChat'] = {
    bundleID = 'com.apple.iChat',
    tags = {'#communication'}
  },
  ['com.valvesoftware.steam'] = {
    bundleID = 'com.valvesoftware.steam',
    tags = {'#distraction'}
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

local hyper       = require 'hyper'
      hyper.start()
local autolayout  = require 'autolayout'
      autolayout.start()
local movewindows = require 'movewindows'
      movewindows.start()
local airpods     = require 'airpods'
local brave       = require 'brave'
local headspace   = require 'headspace'
      headspace.start()
local toggl       = require('toggl')
      toggl.start()

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

