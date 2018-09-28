config = {}

-- Hyper+key for all the below are handled in some other software
-- "fall through".
config.hyper_fall_through = {'c', 'space', '\\', 'p', '\''}

config.applications = {
  ['iTerm'] = {
    name = 'iTerm',
    hyper_shortcut = 'j',
    preferred_display = 1
  },
  ['Google Chrome'] = {
    name = 'Google Chrome',
    hyper_shortcut = 'k',
    preferred_display = 1
  },
  ['Dash'] = {
    name = 'Dash',
    hyper_shortcut = 'h'
  },
  ['Slack'] = {
    name = 'Slack',
    hyper_shortcut = 'i',
    preferred_display = 2
  },
  ['Microsoft Outlook'] = {
    name = 'Microsoft Outlook',
    hyper_shortcut = 'e',
    preferred_display = 2
  },
  ['Finder'] = {
    name = 'Finder',
    hyper_shortcut = 'f'
  },
  ['Discord'] = {
    name = 'Discord',
    hyper_shortcut = 'l',
    preferred_display = 2
  },
  ['zoom.us'] = {
    name = 'zoom.us',
    hyper_shortcut = 'z',
    preferred_display = 2
  },
  ['Sketch'] = {
    name = 'Sketch',
    hyper_shortcut = 'v',
    preferred_display = 1
  },
}


require 'autolayout'
require 'hyper'
require 'movewindows'
require 'keyboardhacks'
