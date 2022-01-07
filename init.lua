local secrets = require('secrets')
      secrets.start('.secrets.json')

hs.loadSpoon('Hyper')
hs.loadSpoon('Headspace')
hs.loadSpoon('Teamz'):start()
hs.loadSpoon('ElgatoKey'):start()

IsDocked = function()
  return hs.fnutils.some(hs.usb.attachedDevices(), function(device)
    return device.productName == "CalDigit Thunderbolt 3 Audio"
  end)
end

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

Hyper:bindHotKeys({hyperKey = {{}, 'F19'}})

hs.fnutils.each(Config.applications, function(appConfig)
  if appConfig.hyperKey then
    Hyper:bind({}, appConfig.hyperKey, function() hs.application.launchOrFocusByBundleID(appConfig.bundleID) end)
  end
  if appConfig.localBindings then
    hs.fnutils.each(appConfig.localBindings, function(key)
      Hyper:bindPassThrough(key, appConfig.bundleID)
    end)
  end
end)

-- provide the ability to override config per computer
if (hs.fs.displayName('./localConfig.lua')) then
  require('localConfig')
end

Movewindows = require('movewindows')
Movewindows:start()

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

local hyperGroup = function(key, tag)
  Hyper:bind({}, key, nil, function()
    hs.application.launchOrFocusByBundleID(hs.settings.get("group." .. tag))
  end)
  Hyper:bind({'option'}, key, nil, function()
    local group =
      hs.fnutils.filter(Config.applications, function(app)
        return app.tags and
               hs.fnutils.contains(app.tags, tag) and
               app.bundleID ~= hs.settings.get("group." .. tag)
      end)

    local choices = {}
    hs.fnutils.each(group, function(app)
      table.insert(choices, {
        text = hs.application.nameForBundleID(app.bundleID),
        image = hs.image.imageFromAppBundle(app.bundleID),
        bundleID = app.bundleID
      })
    end)

    if #choices == 1 then
      local app = choices[1]

      hs.notify.new(nil)
      :title("Switching hyper+" .. key .. " to " .. hs.application.nameForBundleID(app.bundleID))
      :contentImage(hs.image.imageFromAppBundle(app.bundleID))
      :send()

      hs.settings.set("group." .. tag, app.bundleID)
      hs.application.launchOrFocusByBundleID(app.bundleID)
    else
      hs.chooser.new(function(app)
        if app then
          hs.settings.set("group." .. tag, app.bundleID)
          hs.application.launchOrFocusByBundleID(app.bundleID)
        end
      end)
      :placeholderText("Choose an application for hyper+" .. key .. ":")
      :choices(choices)
      :show()
    end
  end)
end

hyperGroup('q', 'personal')
hyperGroup('k', 'browsers')
hyperGroup('i', 'chat')

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
