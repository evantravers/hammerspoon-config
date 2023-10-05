--- === Teamz ===
--- Microsoft Teams is difficult to work with... they don't name their windows
--- consistently. This is a wrapper that keeps track of a Microsoft Teams
--- application, and isolating the hs.window that contains the call.

local m = {
  name = "Teamz",
  version = "0.9",
  author = "Evan Travers <evantravers@gmail.com>",
  license = "MIT <https://opensource.org/licenses/MIT>",
  homepage = "https://github.com/evantravers/Teamz.spoon",
}

--- Teamz:start() -> table
--- Method
--- Starts an hs.application.watcher that listens for Microsoft Teams and
--- stores the first real window created.
---
--- Returns:
---  * self
function m:start()
  m.watcher = hs.application.watcher.new(function(appName, event, hsApp)
    if hsApp:bundleID() == 'com.microsoft.teams2' then
      if event == hs.application.watcher.launching then
        hs.timer.waitUntil(function()
          return hsApp:mainWindow() ~= nil and not string.match(hsApp:mainWindow():title(), "Loading")
        end,
        function()
          m.app = hsApp
          m.firstWindow = hsApp:mainWindow()
        end)
      end
    end
  end)
  :start()

  return self
end

--- Teamz:stop() -> table
--- Method
--- Kills the watcher and destroy it
---
--- Returns:
---  * self
function m:stop()
  m.watcher:stop()
  m.watcher = nil

  return self
end

local function checkAttachment()
  if m.app == nil then
    hs.application.launchOrFocusByBundleID('com.microsoft.teams2')
    m.app = hs.application.find('com.microsoft.teams2')
  end

  if m.firstWindow == nil then
    local count = 0
    hs.fnutils.each(m.app:allWindows(), function()
      count = count + 1
    end)

    -- if there's only one window, that's it
    if count == 1 then
      m.firstWindow = m.app:mainWindow()
    else
      hs.chooser.new(function(choice)
        m.firstWindow = hs.window.find(choice.id)
      end)
      :placeholderText("Which of these is the chat window?")
      :choices(hs.fnutils.map(m.app:allWindows(), function(win)
        return {
          text = win:title(),
          id = win:id()
        }
      end))
      :show()
    end
  end
end

--- Teamz.callWindow() -> table
--- Method
--- Returns the hs.window that is most likely going to be the window with the
--- video call in it. I usually wind up using Teamz.callWindow():focus()
---
--- Returns:
---  * hs.window
function m.callWindow()
  checkAttachment()

  return hs.fnutils.find(m.app:allWindows(), function(window)
    if window == m.chatWindow() then return false end
    if string.match(window:title(), 'Notification') then return false end
    if string.match(window:title(), 'in progress') then return false end
    return true
  end)
end

--- Teamz.chatWindow() -> table
--- Method
--- Returns the first window launched in Teams. I use it combined with a
--- hs.hotkey binding and hs.window:focus to jump to chat.
---
--- Returns:
---  * hs.window
function m.chatWindow()
  checkAttachment()

  return m.firstWindow
end

return m
