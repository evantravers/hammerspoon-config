--- === Teamz ===

local m = {
  name = "Teamz",
  version = "0.9",
  author = "Evan Travers <evantravers@gmail.com>",
  license = "MIT <https://opensource.org/licenses/MIT>",
  homepage = "https://github.com/evantravers/Teamz.spoon",
}

function m:start() 
  m.watcher = hs.application.watcher.new(function(appName, event, hsApp)
    if hsApp:bundleID() == 'com.microsoft.teams' then
      if event == hs.application.watcher.launched then
        local wait = hs.timer.doAfter(1, function()
          m.app = hsApp
          m.mainWindow = hsApp:mainWindow()
        end)
      end
    end
  end)
  :start()

  return self
end

function m:stop()
  m.watcher:stop()
  m.watcher = nil
end

function m:isRunning()
  if m.app then
    return true
  else
    return false
  end
end

function m:callWindow()
  return hs.fnutils.find(m.app:allWindows(), function(window)
    if window == m.mainWindow then
      return false
    end
    if string.match(window:title(), 'Notification') then
      return false
    end
    if string.match(window:title(), 'in progress') then
      return false
    end
    return true
  end)
end

return m
