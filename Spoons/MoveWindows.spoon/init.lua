--- === MoveWindows ===
---
--- MoveWindows is a "moom" style window mover, originally written by @tmiller
--- that I've adapted over the years.
---
--- At it's core, MoveWindows provides a sane set of default vim-style
--- keybindings to move windows around, but you can override anything at any
--- point.
---
--- If you wish to adjust the bindings and "grid", simply set or extend
--- MoveWindows.grid before calling `MoveWindows:start()`.
---
--- MoveWindows exposes the bindHotKeys method for `MoveWindows.toggle()`, but
--- you can bind against it directly, especially if you want to call it from
--- another lua script/modal like Hyper.spoon

local m = hs.hotkey.modal.new({}, nil)

m.name = "MoveWindows"
m.version = "0.9"
m.author = "Evan Travers <evantravers@gmail.com>"
m.license = "MIT <https://opensource.org/licenses/MIT>"
m.homepage = "https://github.com/evantravers/hammerspoon-config/Spoons/MoveWindows/"

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

-- Once you've loaded the spoon, you can redefine this.
m.grid = {
  { key='j', unit=hs.geometry.rect(0, 0.5, 1, 0.5) },
  { key='k', unit=hs.geometry.rect(0, 0, 1, 0.5) },
  { key='h', unit=hs.layout.left50 },
  { key='l', unit=hs.layout.right50 },

  { key='y', unit=hs.geometry.rect(0, 0, 0.5, 0.5) },
  { key='u', unit=hs.geometry.rect(0.5, 0, 0.5, 0.5) },
  { key='b', unit=hs.geometry.rect(0, 0.5, 0.5, 0.5) },
  { key='n', unit=hs.geometry.rect(0.5, 0.5, 0.5, 0.5) },

  { key='r', unit=hs.layout.left70 },
  { key='t', unit=hs.layout.right30 },

  { key='space', unit=hs.layout.maximized },
}

function m:start()
  -- disable animations
  hs.window.animationDuration = 0

  hs.fnutils.each(m.grid, function(entry)
    m:bind('shift', entry.key, function()
      hs.window.focusedWindow()
        :moveToScreen(hs.window.focusedWindow():screen():next())
        :moveToUnit(entry.unit)
      m:exit()
    end)
    m:bind('', entry.key, function()
      hs.window.focusedWindow():moveToUnit(entry.unit)
      m:exit()
    end)
  end)

  -- provide alternate escapes
  m
  :bind('ctrl', '[', function() m:exit() end)
  :bind('', 'escape', function() m:exit() end)

  return self
end

--- MoveWindows:bindHotKeys(table) -> hs.hotkey.modal
--- Method
--- Expects a table in the form: `{toggle = {{<mods>}, <key>}}`
---
--- Returns:
---  * self
function m:bindHotKeys(mapping)
  local spec = {
    toggle = hs.fnutils.partial(self.toggle, self)
  }

  hs.spoons.bindHotkeysToSpec(spec, mapping)

  return self
end

return m
