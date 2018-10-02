-- should be under hyper-p
-- should be a little menu modal thing that pops up
-- if no timer started
--   allows you to hit enter to start
-- if timer started
--   shows you remaining time
--   enter to stop
--   space to pause

-- on start should close list of distractions
-- on pause/stop should open distractions back up
-- ideally changes the /etc/hosts too

local hsApp = require("hs.application")

local pomoMode = hs.hotkey.modal.new('cmd', 'l')
local defaultPomodoroLength = 25
local closedDistractions = {}

function showPrompt(str)
  hs.alert.closeAll()
  hs.fnutils.imap(hs.screen.allScreens(), function(screen)
    return hs.alert.show(str, hs.alert.defaultStyle, screen, true)
  end)
end

function pomoMode:entered()
  showPrompt("Pomodoros!")
end

function pomoMode:exited()
  hs.alert.closeAll()
end

function startOrStopPomodoro()
  if timer then
    showPrompt("Stopping pomodoro!")
    timer = false
    for _, app in pairs(closedDistractions) do
      hsApp.launchOrFocus(app)
    end
    closedDistractions = {}
  else
    showPrompt("Starting pomodoro! 25 minutes to go!")
    timer = true
    for _, app in pairs(config.applications) do
      pid = hsApp.find(app.name)
      if pid and app.distraction then
        table.insert(closedDistractions, app.name) -- keep track of it
        pid:kill()
      end
    end
  end
end

pomoMode:bind('', 'escape', function() pomoMode:exit() end)

pomoMode:bind('', 'return', startOrStopPomodoro)
