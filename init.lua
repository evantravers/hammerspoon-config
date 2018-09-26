config = {}

-- Hyper+key for all the below are handled in some other software
-- "fall through".
config.hyper_fall_through = {'c', 'space', '\\', 'p', '\''}

config.applications = {
  {
    name = 'iTerm',
    hyper_shortcut = 'j',
    preferred_display = 1
  },
  {
    name = 'Google Chrome',
    hyper_shortcut = 'k',
    preferred_display = 1
  },
  {
    name = 'Dash',
    hyper_shortcut = 'h'
  },
  {
    name = 'Slack',
    hyper_shortcut = 'i',
    preferred_display = 2
  },
  {
    name = 'Microsoft Outlook',
    hyper_shortcut = 'e',
    preferred_display = 2
  },
  {
    name = 'Finder',
    hyper_shortcut = 'f'
  },
  {
    name = 'Discord',
    hyper_shortcut = 'l',
    preferred_display = 2
  },
  {
    name = 'zoom.us',
    hyper_shortcut = 'z',
    preferred_display = 2
  },
  {
    name = 'Sketch',
    hyper_shortcut = 'v',
    preferred_display = 1
  },
}


require 'autolayout'
require 'hyper'
require 'movewindows'
require 'keyboardhacks'
