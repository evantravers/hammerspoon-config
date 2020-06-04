local fn   = require('hs.fnutils')
local util = require('util')
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

module.urlsTaggedWith = function(tag)
  return fn.filter(config.domains, function(domain)
    return domain.tags and fn.contains(domain.tags, tag)
  end)
end

module.launch = function(list)
  fn.map(list, function(tag_or_url)
    if util.isTag(tag_or_url) then -- tag
      fn.map(module.urlsTaggedWith(tag_or_url), function(site)
        hs.urlevent.openURL("http://" .. site.url)
      end)
    else -- url
      hs.urlevent.openURL("http://" .. tag_or_url)
    end
  end)
end

module.kill = function(list)
  fn.map(list, function(tag_or_url)
    if util.isTag(tag_or_url) then -- tag
      fn.map(module.urlsTaggedWith(tag_or_url), function(site) module.killTabsByDomain(site.url) end)
    else -- url
      module.killTabsByDomain(tag_or_url)
    end
  end)
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
