local secrets = require('secrets')
      secrets.start('.secrets.json')

hs.loadSpoon('Hyper')
hs.loadSpoon('Headspace')
hs.loadSpoon('Teamz'):start()

Config = {}
Config.applications = require('configApplications')

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
require('spaces/leadership')
require('spaces/play')
require('spaces/weekly_review')
require('spaces/start')
require('spaces/shutdown')

Hyper = spoon.Hyper

-- provide the ability to override config per computer
if (hs.fs.displayName('./localConfig.lua')) then
  require('localConfig')
end

Hyper
:start(Config)
:setHyperKey('F19')

Movewindows = require('movewindows')
Movewindows.start()

local autolayout = require('autolayout')
      autolayout.start(Config)
      Hyper:bind({}, 'return', nil, autolayout.autoLayout)

local brave = require('brave')
      brave.start(Config)

spoon.Headspace:start()
               :loadConfig(Config)
               :setTogglKey(hs.settings.get('secrets').toggl.key)

Hyper:bind({}, 'l', nil, spoon.Headspace.choose)

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
    spoon.Teamz.callWindow():focus()
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

require('browserSnip')
