-- double tap ctrl for esc

ctrlDoublePress = require("ctrlDoublePress")
ctrlDoublePress.timeFrame = 1
ctrlDoublePress.action = function()
  hs.eventtap.keyStroke({}, "escape")
end
