-- BRAVE
--
-- Some utility functions for controlling Brave Browser.
-- Probably would work super similarly on Chrome and Safari, or any webkit
-- browser.
--
-- NOTE: May require you enable View -> Developer -> Allow Javascript from
-- Apple Events in Brave's menu.

local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.jump = function(url)
  hs.osascript.javascript([[
  (function() {
    var brave = Application('Brave');
    brave.activate();

    for (win of brave.windows()) {
      var tabIndex =
        win.tabs().findIndex(tab => tab.url().match(/]] .. url .. [[/));

      if (tabIndex != -1) {
        win.activeTabIndex = (tabIndex + 1);
        win.index = 1;
      }
    }
  })();
  ]])
end

module.killTabsByDomain = function(domain)
  hs.osascript.javascript([[
  (function() {
    var brave = Application('Brave');

    for (win of brave.windows()) {
      for (tab of win.tabs()) {
        if (tab.url().match(/]] .. string.gsub(domain, '/', '\\/') .. [[/)) {
          tab.close()
        }
      }
    }
  })();
  ]])
end

return module
