-- Window shortcuts from @tmiller

local movewindows = hs.hotkey.modal.new()

function movewindows:entered()
  alertUuids = hs.fnutils.imap(hs.screen.allScreens(), function(screen)
    local prompt = string.format("◱ : %s",
                                 window.focusedWindow():application():title())
    return hs.alert.show(prompt, hs.alert.defaultStyle, screen, true)
  end)
end

function movewindows:exited()
  hs.fnutils.ieach(alertUuids, function(uuid)
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

movewindows.start = function()
  local hyper = require("hyper")
  local window  = hs.window
  window.animationDuration = 0

  hyper:bind({}, 'm', nil, function() movewindows:enter() end)

  hs.fnutils.each(movewindows.grid, function(entry)
    movewindows:bind('', entry.key, function()
      window.focusedWindow():moveToUnit(entry.unit)
      movewindows:exit()
    end)

    movewindows:bind('ctrl', '[', function() movewindows:exit() end)
    movewindows:bind('', 'escape', function() movewindows:exit() end)

    movewindows:bind('shift', 'h', function()
      window.focusedWindow():moveOneScreenWest()
      movewindows:exit()
    end)

    movewindows:bind('shift', 'l', function()
      window.focusedWindow():moveOneScreenEast()
      movewindows:exit()
    end)

    movewindows:bind('', 'tab', function ()
      window:focusedWindow():centerOnScreen()
      movewindows:exit()
    end)
  end)
end

return movewindows
