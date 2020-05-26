local hyper = require("hyper")
local fn    = require('hs.fnutils')

local module = {}

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

module.killTabsByTag = function(tag)
  local toKill = fn.filter(config.websites, function(w)
    return w.tags and fn.contains(w.tags, tag)
  end)

  fn.map(toKill, function(site) module.killTabsByDomain(site.url) end)
end

module.killTabsByDomain = function(domain)
  hs.osascript.javascript([[
  (function() {
    var brave = Application('Brave');

    for (win of brave.windows()) {
      for (tab of win.tabs()) {
        if (tab.url().match(/]] .. domain .. [[/)) {
          tab.close()
        }
      }
    }
  })();
  ]])
end

return module
