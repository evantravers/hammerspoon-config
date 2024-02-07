--- === HyperModal ===

local m = hs.hotkey.modal.new({}, nil)

m.name = "HyperModal"
m.version = "0.0.1"
m.author = "Evan Travers <evantravers@gmail.com>"
m.license = "MIT <https://opensource.org/licenses/MIT>"
m.homepage = "https://github.com/evantravers/hammerspoon-config/Spoons/HyperModal/"

-- initialize it as "closed"
m.isOpen = false

function m:entered()
  m.isOpen = true
  m.alertUuids = hs.fnutils.map(hs.screen.allScreens(), function(screen)
    local prompt = string.format("🖥 : %s",
                                 hs.window.focusedWindow():application():title())
    return hs.alert.show(prompt, hs.alert.defaultStyle, screen, true)
  end)

  return self
end

function m:exited()
  m.isOpen = false
  hs.fnutils.ieach(m.alertUuids, function(uuid)
    hs.alert.closeSpecific(uuid)
  end)

  return self
end

function m:toggle()
  if m.isOpen then
    m:exit()
  else
    m:enter()
  end

  return self
end

function m:start()
  -- disable animations
  hs.window.animationDuration = 0

  -- provide alternate escapes
  m
  :bind('ctrl', '[', function() m:exit() end)
  :bind('', 'escape', function() m:exit() end)

  return self
end

function m:bindHotKeys(mapping)
  local spec = {
    toggle = hs.fnutils.partial(self.toggle, self)
  }

  hs.spoons.bindHotkeysToSpec(spec, mapping)

  return self
end

return m
