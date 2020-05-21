config = {}

config.applications = {
  {
    bundleID = 'com.runningwithcrayons.Alfred',
    local_bindings = {'c', 'space', 'o', 's'}
  },
  {
    bundleID = 'net.kovidgoyal.kitty',
    hyper_shortcut = 'j',
    preferred_display = 1,
    tags = {'coding'}
  },
  {
    bundleID = 'com.brave.browser',
    hyper_shortcut = 'k',
    preferred_display = 1,
    tags = {'coding', 'writing'}
  },
  {
    bundleID = 'org.mozilla.firefox',
    hyper_shortcut = 'b',
    preferred_display = 1
  },
  {
    bundleID = 'com.kapeli.dashdoc',
    hyper_shortcut = 'h',
    tags = {'coding'}
  },
  {
    bundleID = 'com.tinyspeck.slackmacgap',
    hyper_shortcut = 'i',
    preferred_display = 2,
    tags = {'distraction', 'communication'}
  },
  {
    bundleID = 'com.apple.mail',
    hyper_shortcut = 'e',
    preferred_display = 2,
    tags = {'distraction', 'communication'}
  },
  {
    bundleID = 'com.flexibits.fantastical2.mac',
    hyper_shortcut = 'y',
    local_bindings = {']'},
    tags = {'planning', 'review'},
    preferred_display = 2,
  },
  {
    bundleID = 'com.apple.finder',
    hyper_shortcut = 'f'
  },
  {
    bundleID = 'com.hnc.Discord',
    preferred_display = 2,
    tags = {'distraction'}
  },
  {
    bundleID = 'com.tapbots.Tweetbot3Mac',
    tags = {'distraction'},
    local_bindings = {'\\'}
  },
  {
    bundleID = 'com.culturedcode.ThingsMac',
    hyper_shortcut = 't',
    preferred_display = 1,
    tags = {'planning', 'review'},
    local_bindings = {',', '.'}
  },
  {
    bundleID = 'com.agiletortoise.Drafts-OSX',
    hyper_shortcut ='d',
    tags = {'review'},
    local_bindings = {'x', ';'}
  },
  {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    local_bindings = {'l'}
  },
  {
    bundleID = 'com.ideasoncanvas.mindnode.macos',
    hyper_shortcut = 'u',
    preferred_display = 1
  }
}

local hyper = require 'hyper'

require 'autolayout'
require 'movewindows'
require 'pomodoro'
require 'airpods'
require 'headspace'
require 'tabjump'

hyper:bind({}, 'r', nil, function() hs.reload() end)

hyper:bind({}, 'a', nil, function()
  local ok, output = airPods('Evan’s AirPods')
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
    tabjump("meet.google.com|hangouts.google.com.call")
  end
end)

-- Jump to figma
hyper:bind({}, 'v', nil, function()
  if hs.application.find('com.figma.Desktop') then
    hs.application.launchOrFocusByBundleID('com.figma.Desktop')
  else
    tabjump("lucidchart.com|figma.com")
  end
end)

