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

local pomoMode = hs.hotkey.modal.new('cmd', 'l')
local defaultPomodoroLength = 25

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
  else
    showPrompt("Starting pomodoro! 25 minutes to go!")
    timer = true
  end
end

pomoMode:bind('', 'escape', function() pomoMode:exit() end)

pomoMode:bind('', 'return', startOrStopPomodoro)
