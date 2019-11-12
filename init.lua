config = {}

config.applications = {
  {
    hint = 'com.runningwithcrayons.Alfred',
    local_bindings = {'c', 'space', 'o'}
  },
  {
    hint = 'net.kovidgoyal.kitty',
    hyper_shortcut = 'j',
    preferred_display = 1
  },
  {
    hint = 'com.brave.browser',
    hyper_shortcut = 'k',
    preferred_display = 1
  },
  {
    hint = 'org.mozilla.firefox',
    hyper_shortcut = 'w',
    preferred_display = 1
  },
  {
    hint = 'com.kapeli.dashdoc',
    hyper_shortcut = 'h'
  },
  {
    hint = 'com.tinyspeck.slackmacgap',
    hyper_shortcut = 'i',
    preferred_display = 2,
    distraction = true
  },
  {
    hint = 'com.apple.mail',
    hyper_shortcut = 'e',
    preferred_display = 2,
    distraction = true
  },
  {
    hint = 'com.flexibits.fantastical2.mac',
    hyper_shortcut = 'y',
    local_bindings = {']'},
    preferred_display = 2,
  },
  {
    hint = 'com.apple.finder',
    hyper_shortcut = 'f'
  },
  {
    hint = 'com.hnc.Discord',
    preferred_display = 2,
    distraction = true
  },
  {
    hint = 'com.bohemiancoding.sketch3',
    hyper_shortcut = 'v',
    preferred_display = 1
  },
  {
    hint = 'com.tapbots.Tweetbot3Mac',
    distraction = true,
    local_bindings = {'\\'}
  },
  {
    hint = 'com.culturedcode.ThingsMac',
    hyper_shortcut = 't',
    preferred_display = 1,
    local_bindings = {',', '.'}
  },
  {
    hint = 'com.agiletortoise.Drafts-OSX',
    hyper_shortcut ='d',
    local_bindings = {'x', ';'}
  },
  {
    hint = 'com.toggl.toggldesktop.TogglDesktop',
    local_bindings = {'l'}
  },
}

local hyper = require 'hyper'

require 'autolayout'
require 'movewindows'
require 'pomodoro'
require 'airpods'
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
