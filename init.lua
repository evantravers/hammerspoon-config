hs.loadSpoon('Hyper')
hs.loadSpoon('Headspace'):start()
hs.loadSpoon('Teamz'):start()
hs.loadSpoon('ElgatoKey'):start()
hs.loadSpoon('HyperModal')
hs.loadSpoon('Split')

IsDocked = function()
  return hs.fnutils.some(hs.usb.attachedDevices(), function(device)
    return device.productName == "CalDigit Thunderbolt 3 Audio"
  end)
end

Config = {}
Config.applications = require('configApplications')

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

-- https://github.com/dmitriiminaev/Hammerspoon-HyperModal/blob/master/.hammerspoon/yabai.lua
local yabai = function(args, completion)
  local yabai_output = ""
  local yabai_error = ""
  -- Runs in background very fast
  local yabai_task = hs.task.new("/run/current-system/sw/bin/yabai", function(err, stdout, stderr)
    print()
  end, function(task, stdout, stderr)
      -- print("stdout:"..stdout, "stderr:"..stderr)
      if stdout ~= nil then
        yabai_output = yabai_output .. stdout
      end
      if stderr ~= nil then
        yabai_error = yabai_error .. stderr
      end
      return true
    end, args)
  if type(completion) == "function" then
    yabai_task:setCallback(function()
      completion(yabai_output, yabai_error/run/current-system/sw/bin/yabai)
    end)
  end
  yabai_task:start()
end

HyperModal = spoon.HyperModal
HyperModal
  :start()
  :bind('', "1", function()
    yabai({"-m", "window", "--warp", "first"})
    HyperModal:exit()
  end)
  :bind('', "space", function()
    yabai({"-m", "window", "--toggle", "zoom-parent"})
    HyperModal:exit()
  end)
  :bind('', "h", function()
    yabai({"-m", "window", "--warp", "west"})
    HyperModal:exit()
  end)
  :bind('', "j", function()
    yabai({"-m", "window", "--warp", "south"})
    HyperModal:exit()
  end)
  :bind('', "k", function()
    yabai({"-m", "window", "--warp", "north"})
    HyperModal:exit()
  end)
  :bind('', "l", function()
    yabai({"-m", "window", "--warp", "east"})
    HyperModal:exit()
  end)
  :bind('', ';', function()
    hs.urlevent.openURL("raycast://extensions/raycast/system/toggle-system-appearance")
    HyperModal:exit()
  end)

Hyper:bind({}, 'm', function() HyperModal:toggle() end)

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
    elseif hs.application.find('com.microsoft.teams2') then
      hs.application.launchOrFocusByBundleID('com.microsoft.teams2')
      local call = hs.settings.get("call")
      call:focus()
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

-- sync tags to OSX
-- Currently unused, because of permissions
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

-- change audio settings based on output
hs.audiodevice.watcher.setCallback(function(event)
  if event == "dOut" then
    local name = hs.audiodevice.defaultOutputDevice():name()
    if name == "WH-1000XM4" then
      hs.shortcuts.run("XM4")
    end
    if name == "MacBook Pro Speakers" then
      hs.shortcuts.run("Macbook Pro Speakers")
    end
  end
end)
hs.audiodevice.watcher.start()

Hyper:bind({}, 'w', nil, function()
  hs.window.focusedWindow():application():selectMenuItem({"Edit", "Start Dictation"})
end)
