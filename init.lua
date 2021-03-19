local secrets = require('secrets')
      secrets.start('.secrets.json')

Config = {}
Config.applications = {
  ['com.runningwithcrayons.Alfred'] = {
    bundleID = 'com.runningwithcrayons.Alfred',
    local_bindings = {'c', 'space', 'o', 'l'}
  },
  ['net.kovidgoyal.kitty'] = {
    bundleID = 'net.kovidgoyal.kitty',
    hyper_key = 'j',
    tags = {'coding'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.brave.Browser'] = {
    bundleID = 'com.brave.Browser',
    hyper_key = 'k',
    rules = {
      {nil, 1, hs.layout.maximized},
      {"Confluence", 1, hs.layout.maximized},
      {"Meet - ", 2, hs.layout.maximized},
    }
  },
  ['org.mozilla.firefox'] = {
    bundleID = 'org.mozilla.firefox',
    hyper_key = 'b',
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.kapeli.dashdoc'] = {
    bundleID = 'com.kapeli.dashdoc',
    hyper_key = 'h',
    tags = {'coding'}
  },
  ['com.tinyspeck.slackmacgap'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    hyper_key = 'i',
    tags = {'communication'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.microsoft.teams'] = {
    bundleID = 'com.microsoft.teams',
    tags = {'communication'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.apple.mail'] = {
    bundleID = 'com.apple.mail',
    hyper_key = 'e',
    tags = {'communication'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.flexibits.fantastical2.mac'] = {
    bundleID = 'com.flexibits.fantastical2.mac',
    hyper_key = 'y',
    local_bindings = {']'},
    tags = {'planning', 'review', 'calendar'},
    whitelisted = true,
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.apple.finder'] = {
    bundleID = 'com.apple.finder',
    hyper_key = 'f'
  },
  ['com.hnc.Discord'] = {
    bundleID = 'com.hnc.Discord',
    tags = {'distraction'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.tapbots.Tweetbot3Mac'] = {
    bundleID = 'com.tapbots.Tweetbot3Mac',
    tags = {'distraction', 'socialmedia'},
    local_bindings = {'\\'}
  },
  ['com.culturedcode.ThingsMac'] = {
    bundleID = 'com.culturedcode.ThingsMac',
    hyper_key = 't',
    tags = {'planning', 'review', 'tasks'},
    whitelisted = true,
    local_bindings = {',', '.'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
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
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.apple.MobileSMS'] = {
    bundleID = 'com.apple.MobileSMS',
    hyper_key = 'q',
    tags = {'communication', 'distraction'},
    rules = {
      {nil, 2, hs.layout.right30}
    }
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
    tags = {'design'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.reederapp.5.macOS'] = {
    bundleID = 'com.reederapp.5.macOS',
    hyper_key = 'n',
    tags = {'distraction'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['md.obsidian'] = {
    bundleID = 'md.obsidian',
    hyper_key = 'g',
    tags = {'research', 'notes'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['us.zoom.xos'] = {
    bundleID = 'us.zoom.xos',
    rules = {
      {"Zoom Meeting", 2, hs.layout.maximized}
    }
  },
  ['org.whispersystems.signal-desktop'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    tags = {'distraction', 'communication'}
  }
}

Config.domains = {
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

-- provide the ability to override config per computer
if (hs.fs.displayName('./local_config.lua')) then
  require('local_config')
end

-- configure spaces for headspace
Config.spaces = {}
Config.funcs = {}
Config.projects = hs.settings.get("secrets").toggl.projects

require('spaces/review')
require('spaces/schedule')
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

Hyper = require('hyper')
Hyper.start(Config)

Movewindows = require('movewindows')
Movewindows.start()

local autolayout = require('autolayout')
      autolayout.start(Config)
      Hyper:bind({}, 'return', nil, autolayout.autoLayout)

local brave = require('brave')
      brave.start(Config)

Headspace = require('headspace')
      Headspace:enable_watcher()
      Headspace.start(Config)
      Hyper:bind({}, 'l', nil, Headspace.choose)

-- Random bindings
Hyper:bind({}, 'r', nil, function()
  hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)
Hyper:bind({'shift'}, 'r', nil, function() hs.reload() end)

-- Jump to google hangout or zoom
Hyper:bind({}, 'z', nil, function()
  if hs.application.find('us.zoom.xos') then
    hs.application.launchOrFocusByBundleID('us.zoom.xos')
  elseif hs.application.find('com.microsoft.teams') then
    hs.application.launchOrFocusByBundleID('com.microsoft.teams')
  else
    brave.jump("meet.google.com|hangouts.google.com.call")
  end
end)

-- Jump to figma
Hyper:bind({}, 'v', nil, function()
  if hs.application.find('com.figma.Desktop') then
    hs.application.launchOrFocusByBundleID('com.figma.Desktop')
  elseif hs.application.find('com.adobe.LightroomClassicCC7') then
    hs.application.launchOrFocusByBundleID('com.adobe.LightroomClassicCC7')
  else
    brave.jump("lucidchart.com|figma.com")
  end
end)

-- https://stackoverflow.com/questions/19326368/iterate-over-lines-including-blank-lines
local function magiclines(s)
  if s:sub(-1)~="\n" then s=s.."\n" end
  return s:gmatch("(.-)\n")
end

-- Snip current highlight
Hyper:bind({}, 's', nil, function()
  local win = hs.window.focusedWindow()

  -- get the window title
  local title = win:title()
                   :gsub("- Brave", "")
                   :gsub("- Google Chrome", "")
  -- get the highlighted item
  hs.eventtap.keyStroke('command', 'c')
  local highlight = hs.pasteboard.readString()
  local quote = ""
  for line in magiclines(highlight) do
    quote = quote .. "> " .. line .. "\n"
  end
  -- get the URL
  hs.eventtap.keyStroke('command', 'l')
  hs.eventtap.keyStroke('command', 'c')
  local url = hs.pasteboard.readString():gsub("?utm_source=.*", "")
  --
  local template = string.format([[%s

%s
[%s](%s)]], title, quote, title, url)
  -- format and send to drafts
  hs.urlevent.openURL("drafts://x-callback-url/create?tag=links&text=" .. hs.http.encodeForQuery(template))
  hs.notify.show("Snipped!", "The snippet has been sent to Drafts", "")
end)
