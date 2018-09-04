config = {}

-- Hyper+key for all the below are handled in some other software
-- "fall through".
config.hyper_fall_through = {'c', 'space', '\\', 'p'}

config.applications = {
  {name = 'iTerm', hyper_shortcut = 'j' },
  {name = 'Google Chrome', hyper_shortcut = 'k' },
  {name = 'Dash', hyper_shortcut = 'h' },
  {name = 'Slack', hyper_shortcut = 'i' },
  {name = 'Microsoft Outlook', hyper_shortcut = 'e' },
  {name = 'Finder', hyper_shortcut = 'f' },
  {name = 'Discord', hyper_shortcut = 'l' },
  {name = 'zoom.us', hyper_shortcut = 'z' },
  {name = 'Sketch', hyper_shortcut = 'v' },
}



require 'hyper'
require 'movewindows'
