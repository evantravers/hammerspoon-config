-- Window shortcuts from @tmiller

local hyper = require("hyper")
local screenMode = hs.hotkey.modal.new()

hyper:bind({}, 'm', nil, function() screenMode:enter() end)

function screenMode:entered()
  alertUuids = hs.fnutils.imap(hs.screen.allScreens(), function(screen)
    return hs.alert.show('Move Window', hs.alert.defaultStyle, screen, true)
  end)
end

function screenMode:exited()
  hs.fnutils.ieach(alertUuids, function(uuid)
    hs.alert.closeSpecific(uuid)
  end)
end

grid = {
  { key='j', unit=hs.geometry.rect(0, 0.5, 1, 0.5) },
  { key='k', unit=hs.geometry.rect(0, 0, 1, 0.5) },
  { key='h', unit=hs.layout.left50 },
  { key='l', unit=hs.layout.right50 },

  { key='y', unit=hs.geometry.rect(0, 0, 0.5, 0.5) },
  { key='u', unit=hs.geometry.rect(0.5, 0, 0.5, 0.5) },
  { key='b', unit=hs.geometry.rect(0, 0.5, 0.5, 0.5) },
  { key='n', unit=hs.geometry.rect(0.5, 0.5, 0.5, 0.5) },

  { key='space', unit=hs.layout.maximized },
}

hs.fnutils.each(grid, function(entry)
  screenMode:bind('', entry.key, function()
    hs.window.focusedWindow():moveToUnit(entry.unit)
    screenMode:exit()
  end)
end)

screenMode:bind('ctrl', '[', function() screenMode:exit() end)
screenMode:bind('', 'escape', function() screenMode:exit() end)

screenMode:bind('cmd', 'h', function()
  hs.window.focusedWindow():moveOneScreenWest()
  screenMode:exit()
end)

screenMode:bind('cmd', 'l', function()
  hs.window.focusedWindow():moveOneScreenEast()
  screenMode:exit()
end)

screenMode:bind('', 'tab', function ()
  hs.window:focusedWindow():centerOnScreen()
  screenMode:exit()
end)

screenMode:bind('cmd', 'm', function() end)
