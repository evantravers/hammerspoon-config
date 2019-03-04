config = {}

config.applications = {
  {
    hint = 'com.runningwithcrayons.Alfred-3',
    local_bindings = {'c', 'space', 'o', '\'', 'u'}
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
    hint = 'co.boxyapp.slack',
    hyper_shortcut = 'i',
    preferred_display = 2,
    distraction = true
  },
  {
    hint = 'it.bloop.airmail2',
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
    hyper_shortcut = 'l',
    preferred_display = 2,
    distraction = true
  },
  {
    hint = 'us.zoom.xos',
    hyper_shortcut = 'z',
    preferred_display = 2
  },
  {
    hint = 'com.bohemiancoding.sketch3',
    hyper_shortcut = 'v',
    preferred_display = 1
  },
  {
    hint = 'com.tapbots.Tweetbot3Mac',
    distraction = true,
    local_bindings = {';'}
  },
  {
    hint = 'com.culturedcode.ThingsMac',
    hyper_shortcut = 't',
    preferred_display = 2,
    local_bindings = {',', '.'}
  },
}

local hyper = require 'hyper'

require 'autolayout'
require 'movewindows'
require 'pomodoro'

hyper:bind({}, 'r', nil, function() hs.reload() end)
