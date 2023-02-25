local secrets = require('secrets')
      secrets.start('.secrets.json')

hs.loadSpoon('Hyper')
hs.loadSpoon('Headspace'):start()
hs.loadSpoon('Teamz'):start()
hs.loadSpoon('ElgatoKey'):start()
hs.loadSpoon('MoveWindows')
hs.loadSpoon('Split')

IsDocked = function()
  return hs.fnutils.some(hs.usb.attachedDevices(), function(device)
    return device.productName == "CalDigit Thunderbolt 3 Audio"
  end)
end

Config = {}
Config.applications = require('configApplications')

-- -- sync tags to OSX
Config.appsync = function()
  hs.fnutils.map(Config.applications, function(a)
    if a["tags"] and a["bundleID"] then
      local app_path = hs.application.pathForBundleID(a["bundleID"]) -- may not be installed!
      if app_path then
        if not a["bundleID"]:find("apple") then
          print("attempting " .. app_path)
          print(hs.inspect(a["tags"]))
          hs.fs.tagsSet(app_path, a["tags"])
        end
      end
    end
  end)
end

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

MoveWindows = spoon.MoveWindows
hs.window.highlight.ui.overlay = true
MoveWindows
  :start()
  :bind('', ',', function()
    hs.window.focusedWindow()
      :application()
      :selectMenuItem("Tile Window to Left of Screen")
    MoveWindows:exit()
  end)
  :bind('', '.', function()
    hs.window.focusedWindow()
      :application()
      :selectMenuItem("Tile Window to Right of Screen")
    MoveWindows:exit()
  end)
  :bind('', 'v', function()
    spoon.Split.split()
    MoveWindows:exit()
  end)
  :bind('', 'tab', function ()
    hs.window.focusedWindow():centerOnScreen()
    MoveWindows:exit()
  end)
  :bind('', 'd', function()
    -- demo mode!
    if MoveWindows.demo then
      hs.execute("defaults write com.apple.finder CreateDesktop -bool true; killall Finder")
      hs.shortcuts.run("DND Off")
      spoon.ElgatoKey.off()
      MoveWindows.demo = false
    else
      hs.shortcuts.run("DND On")
      spoon.ElgatoKey.on()
      local demo = hs.window.focusedWindow()
      hs.execute("defaults write com.apple.finder CreateDesktop -bool false; killAll Finder")
      hs.fnutils.map(demo:otherWindowsSameScreen(), function(win)
        win:minimize()
      end)
      demo:centerOnScreen()
      MoveWindows.demo = true
    end
    MoveWindows:exit()
  end)

Hyper:bind({}, 'm', function() MoveWindows:toggle() end)

local brave = require('brave')
      brave.start(Config)

-- Random bindings
Hyper:bind({}, 'r', nil, function()
  hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)
Hyper:bind({'shift'}, 'r', nil, function() hs.reload() end)

local chooseFromGroup = function(choice)
  local name = hs.application.nameForBundleID(choice.bundleID)

  hs.notify.new(nil)
  :title("Switching ✦-" .. choice.key .. " to " .. name)
  :contentImage(hs.image.imageFromAppBundle(choice.bundleID))
  :send()

  hs.settings.set("group." .. choice.tag, choice.bundleID)
  hs.application.launchOrFocusByBundleID(choice.bundleID)
end

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
        bundleID = app.bundleID,
        key = key,
        tag = tag
      })
    end)

    if #choices == 1 then
      chooseFromGroup(choices[1])
    else
      hs.chooser.new(chooseFromGroup)
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
Z_count = 0
Hyper:bind({}, 'z', nil, function()
  Z_count = Z_count + 1

  hs.timer.doAfter(0.2, function()
    Z_count = 0
  end)

  if Z_count == 2 then
    spoon.ElgatoKey:toggle()
  else
    -- start a timer
    -- if not pressed again then
    if hs.application.find('us.zoom.xos') then
      hs.application.launchOrFocusByBundleID('us.zoom.xos')
    elseif hs.application.find('com.microsoft.teams') then
      local call = spoon.Teamz.callWindow()
      if call then
        call:focus()
      end
    else
      brave.jump("meet.google.com|hangouts.google.com.call")
    end
  end
end)

-- Jump to figma
Hyper:bind({}, 'v', nil, function()
  if hs.application.find('com.figma.Desktop') then
    hs.application.launchOrFocusByBundleID('com.figma.Desktop')
  elseif hs.application.find('com.electron.realtimeboard') then
    hs.application.launchOrFocusByBundleID('com.electron.realtimeboard')
  elseif hs.application.find('com.adobe.LightroomClassicCC7') then
    hs.application.launchOrFocusByBundleID('com.adobe.LightroomClassicCC7')
  else
    brave.jump("lucidchart.com|figma.com")
  end
end)

Hyper:bind({}, 'p', nil, function()
  local _success, projects, _output = hs.osascript.javascript([[
    (function() {
      var Things = Application("Things");
      var divider = /## Resources/;

      Things.launch();

      let getUrls = function(proj) {
        if (proj.notes() && proj.notes().match(divider)) {
          return proj.notes()
                     .split(divider)[1]
                     .replace(divider, "")
                     .split("\n")
                     .map(str => str.replace(/^- /, ""))
                     .filter(s => s != "")
        }
        else {
          return false;
        }
      }

      let projects =
        Things
        .projects()
        .filter(t => t.status() == "open")
        .map(function(proj) {
          return {
            text: proj.name(),
            subText: proj.area().name(),
            urls: getUrls(proj),
            id: proj.id()
          }
        })
        .filter(function(proj) {
          return proj.urls
        });

      return projects;
    })();
  ]])

  hs.chooser.new(function(choice)
    hs.fnutils.each(choice.urls, hs.urlevent.openURL)
    hs.urlevent.openURL("things:///show?id=" .. choice.id)
  end)
  :placeholderText("Choose a project…")
  :choices(projects)
  :show()
end)

require('browserSnip')
