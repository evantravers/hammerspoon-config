-- Set the key you want to be HYPER to F19 in karabiner or keyboard
local hyper = hs.hotkey.modal.new({}, nil)

for _, key in pairs(config.hyper_fall_through) do
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
for _, app in pairs(config.applications) do
  hyper:bind({}, app.hyper_shortcut, function() launch(app.name); end)
end

-- Shortcut to reload config

reload_config = function()
  hs.reload(j)
  hs.alert.show("Config loaded")
end
hyper:bind({}, 'r', nil, reload_config)
hyper:bind({}, 'return', nil, autoLayout)
