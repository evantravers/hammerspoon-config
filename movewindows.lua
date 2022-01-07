-- Window shortcuts originally from @tmiller, now _heavily_ modified.

hs.loadSpoon('Split')

local movewindows = hs.hotkey.modal.new()
movewindows.isOpen = false

local hyper = spoon.Hyper

function movewindows:entered()
  movewindows.isOpen = true
  movewindows.alertUuids = hs.fnutils.map(hs.screen.allScreens(), function(screen)
    local prompt = string.format("🖥 : %s",
                                 hs.window.focusedWindow():application():title())
    return hs.alert.show(prompt, hs.alert.defaultStyle, screen, true)
  end)
end

function movewindows:exited()
  movewindows.isOpen = false
  hs.fnutils.ieach(movewindows.alertUuids, function(uuid)
    hs.alert.closeSpecific(uuid)
  end)
end

movewindows.grid = {
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

function movewindows:toggle()
  if movewindows.isOpen then
    movewindows:exit()
  else
    movewindows:enter()
  end
end

function movewindows:start()
  hs.window.animationDuration = 0

  hyper:bind({}, 'm', nil, function() movewindows:toggle() end)

  hs.fnutils.each(movewindows.grid, function(entry)
    movewindows:bind('shift', entry.key, function()
      hs.window.focusedWindow()
        :moveToScreen(hs.window.focusedWindow():screen():next())
        :moveToUnit(entry.unit)
      movewindows:exit()
    end)
    movewindows:bind('', entry.key, function()
      hs.window.focusedWindow():moveToUnit(entry.unit)
      movewindows:exit()
    end)
  end)

  movewindows
    :bind('ctrl', '[', function() movewindows:exit() end)
    :bind('', 'escape', function() movewindows:exit() end)
    :bind('', ',', function()
      hs.window.focusedWindow()
        :application()
        :selectMenuItem("Tile Window to Left of Screen")
      movewindows:exit()
    end)
    :bind('', '.', function()
      hs.window.focusedWindow()
        :application()
        :selectMenuItem("Tile Window to Right of Screen")
      movewindows:exit()
    end)
    :bind('', 'v', function()
      spoon.Split.split()
      movewindows:exit()
    end)
    :bind('', 'tab', function ()
      hs.window.focusedWindow():centerOnScreen()
      movewindows:exit()
    end)
end

return movewindows
