-- Set the key you want to be HYPER to F19 in karabiner or keyboard
local hyper = hs.hotkey.modal.new({}, nil)

-- Hyper+key for all the below are handled in some other software
-- "fall through".
hyperBindings = {'c', 'space', "\\", 'p'}

for _, key in pairs(hyperBindings) do
  hyper:bind({}, key, nil, function() hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
  end)
end

pressedHyper = function()
  hyper:enter()
end

releasedHyper = function()
  hyper:exit()
end

-- Bind the Hyper key
hs.hotkey.bind({}, 'F19', pressedHyper, releasedHyper)

launch = function(appname)
  hs.application.launchOrFocus(appname)
end

-- Apps that I want to jump to
singleapps = {
  {'j', 'iTerm'},
  {'k', 'Google Chrome'},
  {'u', 'Firefox'},
  {'h', 'Dash'},
  {'i', 'Slack'},
  {'e', 'Microsoft Outlook'},
  {'m', 'Microsoft Outlook'},
  {'f', 'Finder'},
  {'l', 'Discord'},
  {'z', 'zoom.us'},
  {'v', 'Sketch'},
}

for _, app in pairs(singleapps) do
  hyper:bind({}, app[1], function() launch(app[2]); end)
end

-- Shortcut to reload config

reload_config = function()
  hs.reload(j)
  hs.alert.show("Config loaded")
end
hyper:bind({}, 'r', nil, reload_config)
