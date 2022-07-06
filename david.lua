hs.loadSpoon('Split')

-- you can change the binding for this.
hs.hotkey.bind({'command', 'shift'}, 'm', spoon.Split.split)
local spaces = {
-- Things review: creates 1 small 30% things without the side panel and one
-- large 70% things.
  {
    ["text"]     = "Review",
    ["subText"]  = "Plan and Review",
    ["callback"] = "tasks",
    ["image"] = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac')
  },
-- Email: Superhuman in 100% of screen (but offset to hide the side panel
-- (can't do it in superhuman so have to just slide it extra pixels to the
-- right of the screen) and a countdown timer for 15 minutes that
-- automatically kicks me out of this space and closes superhuman when i'm
-- done.
  {
    ["text"]     = "Email",
    ["subText"]  = "Work through email for 15m only.",
    ["callback"] = "email",
    ["image"] = hs.image.imageFromAppBundle('com.superhuman.electron')
  },
-- Zoom: listens for when I launch a zoom and automatically splits zoom to
-- half screen with chrome on the right half and turns off notifications.
-- Would be extra cool to have a very visual way of seeing if my system is
-- muted or not (I know there's a spoon for this), but having a floating
-- screen that says muted or unmuted would be extra nice.
  {
    ["text"]     = "Meeting",
    ["subText"]  = "Focus on others during a meeting.",
    ["callback"] = "meeting",
    ["image"] = hs.image.imageFromAppBundle('us.zoom.xos')
  },
}

-- the hs.chooser doesn't let there be functions in the object it accepts...
-- so we address another object instead.
local callbacks = {
  ["tasks"] = function()
    hs.timer.doAfter(hs.timer.minutes(15), function()
      hs.notify.new("Go back to work!", "Email is not life", "")
    end)
  end,
  ["email"] = function()
  end,
  ["meeting"] = function()
  end
}

local chooser =
  hs.chooser.new(function(choice)
    print(hs.inspect(choice))
    callbacks[choice.callback]()
  end)
  :choices(spaces)

hs.hotkey.bind({'command', 'shift'}, 'l', function() chooser:show() end)
