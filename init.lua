local secrets = require('secrets')
      secrets.start('.secrets.json')

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
    tags = {'coding'}
  },
  ['com.brave.Browser'] = {
    bundleID = 'com.brave.Browser',
    hyper_key = 'k',
    preferred_display = 1
  },
  ['org.mozilla.firefox'] = {
    bundleID = 'org.mozilla.firefox',
    hyper_key = 'b',
    preferred_display = 1
  },
  ['com.kapeli.dashdoc'] = {
    bundleID = 'com.kapeli.dashdoc',
    hyper_key = 'h',
    tags = {'coding'}
  },
  ['com.tinyspeck.slackmacgap'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    hyper_key = 'i',
    preferred_display = 2,
    tags = {'communication'}
  },
  ['com.readdle.smartemail-Mac'] = {
    bundleID = 'com.readdle.smartemail-Mac',
    hyper_key = 'e',
    preferred_display = 2,
    tags = {'communication'}
  },
  ['com.flexibits.fantastical2.mac'] = {
    bundleID = 'com.flexibits.fantastical2.mac',
    hyper_key = 'y',
    local_bindings = {']'},
    tags = {'planning', 'review', 'calendar'},
    whitelisted = true,
    preferred_display = 2,
  },
  ['com.apple.finder'] = {
    bundleID = 'com.apple.finder',
    hyper_key = 'f'
  },
  ['com.hnc.Discord'] = {
    bundleID = 'com.hnc.Discord',
    preferred_display = 2,
    tags = {'distraction'}
  },
  ['com.tapbots.Tweetbot3Mac'] = {
    bundleID = 'com.tapbots.Tweetbot3Mac',
    tags = {'distraction', 'socialmedia'},
    local_bindings = {'\\'}
  },
  ['com.culturedcode.ThingsMac'] = {
    bundleID = 'com.culturedcode.ThingsMac',
    hyper_key = 't',
    preferred_display = 1,
    tags = {'planning', 'review', 'tasks'},
    whitelisted = true,
    local_bindings = {',', '.'}
  },
  ['com.agiletortoise.Drafts-OSX'] = {
    bundleID = 'com.agiletortoise.Drafts-OSX',
    hyper_key ='d',
    tags = {'review', 'writing', 'research', 'notes'},
    whitelisted = true,
    local_bindings = {'x', ';'}
  },
  ['com.toggl.toggldesktop.TogglDesktop'] = {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    local_bindings = {'p'}
  },
  ['com.ideasoncanvas.mindnode.macos'] = {
    bundleID = 'com.ideasoncanvas.mindnode.macos',
    tags = {'research'},
    hyper_key = 'u',
    preferred_display = 1
  },
  ['com.apple.iChat'] = {
    bundleID = 'com.apple.iChat',
    hyper_key = 'q',
    tags = {'communication', 'distraction'}
  },
  ['com.valvesoftware.steam'] = {
    bundleID = 'com.valvesoftware.steam',
    tags = {'distraction'}
  },
  ['com.spotify.client'] = {
    bundleID = 'com.spotify.client'
  },
  ['com.figma.Desktop'] = {
    bundleID = 'com.figma.Desktop',
    tags = {'design'}
  },
  ['md.obsidian'] = {
    bundleID = 'md.obsidian',
    hyper_key = 'g',
    tags = {'research', 'notes'},
    preferred_display = 1
  }
}

config.domains = {
  ['twitter.com'] = {
    url = 'twitter.com',
    tags = {'distraction', 'socialmedia'}
  },
  ['instagram.com'] = {
    url = 'instagram.com',
    tags = {'distraction', 'socialmedia'}
  },
  ['reddit.com'] = {
    url = 'reddit.com',
    tags = {'distraction'}
  },
  ['instapaper.com'] = {
    url = 'instapaper.com',
    tags = {'distraction', 'reading'}
  },
  ['youtube.com'] = {
    url = 'youtube.com',
    tags = {'distraction'}
  }
}

-- configure spaces for headspace
config.spaces = {}
config.setup = {}
config.projects = hs.settings.get("secrets").toggl.projects

require('spaces/review')
require('spaces/focus_budget')
require('spaces/deep')
require('spaces/shallow')
require('spaces/write')
require('spaces/design')
require('spaces/research')
require('spaces/communicate')
require('spaces/focused_meeting')
require('spaces/collaboration')
require('spaces/standup')
require('spaces/play')
require('spaces/weekly_review')
require('spaces/shutdown')

hyper = require('hyper')
hyper.start(config)

movewindows = require('movewindows')
movewindows.start()

local autolayout = require 'autolayout'
      autolayout.start(config)
      hyper:bind({}, 'return', nil, autolayout.autoLayout)

local airpods = require('airpods')

local brave = require('brave')
      brave.start(config)

local headspace = require('headspace')
      headspace:enable_watcher()
      headspace.start(config)
      hyper:bind({}, 'l', nil, headspace.choose)

-- Random bindings
hyper:bind({}, 'r', nil, function()
  hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)
hyper:bind({'shift'}, 'r', nil, function() hs.reload() end)

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
