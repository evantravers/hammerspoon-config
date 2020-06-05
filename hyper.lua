-- Set the key you want to be HYPER to F19 in karabiner or keyboard
local hyper = hs.hotkey.modal.new({}, nil)
local util = require('util')

hyper.pressed = function()
  hyper:enter()
end

hyper.released = function()
  hyper:exit()
end

-- Bind the Hyper key to the hammerspoon modal
hs.hotkey.bind({}, 'F19', hyper.pressed, hyper.released)

hyper.allowed = function(app)
  if app.tags then
    if hs.settings.get("only") then
      return hs.fnutils.some(hs.settings.get("only"), function(tag)
        return hs.fnutils.contains(app.tags, tag)
      end)
    else
      if hs.settings.get("never") then
        return hs.fnutils.every(hs.settings.get("never"), function(tag)
          return not hs.fnutils.contains(app.tags, tag)
        end)
      end
    end
  end
  return true
end

hyper.launch = function(app)
  if hyper.allowed(app) then
    hs.application.launchOrFocusByBundleID(app.bundleID)
  else
    hs.notify.show("Blocked " .. app.bundleID, "You have to switch headspaces", "")
  end
end

hyper.start = function()
  -- Use the hyper key with the application config to use the `hyper_key`
  for _, app in pairs(config.applications) do
    -- Apps that I want to jump to
    if app.hyper_key then
      hyper:bind({}, app.hyper_key, function() hyper.launch(app); end)
    end

    -- I use hyper to power some shortcuts in different apps If the app is closed
    -- and I press the shortcut, open the app and send the shortcut, otherwise
    -- just send the shortcut.
    if app.local_bindings then
      for _, key in pairs(app.local_bindings) do
        hyper:bind({}, key, nil, function()
          if hs.application.find(app.bundleID) then
            hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
          else
            hyper.launch(app)
            hs.timer.waitWhile(
              function() return hs.application.find(app.bundleID) == nil end,
              function()
                hs.eventtap.keyStroke({'cmd','alt','shift','ctrl'}, key)
              end)
          end
        end)
      end
    end
  end
end

return hyper
