local fn = require('hs.fnutils')

module = {}

local function appsTaggedWith(tag)
  return fn.filter(config.applications, function(app)
    return app.tags and fn.contains(app.tags, tag)
  end)
end

-- launches either by tag or by bundle id from a list
module.launch = function(list)
  fn.map(list, function(tag_or_bundle)
    fn.map(appsTaggedWith(tag_or_bundle), function(app)
      hs.application.launchOrFocusByBundleID(app.bundleID)
    end)
  end)
end

module.kill = function(list)
  fn.map(list, function(tag_or_bundle)
    fn.map(appsTaggedWith(tag_or_bundle), function(app)
      fn.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
        app:kill()
      end)
    end)
  end)
end

module.appsTaggedWith = appsTaggedWith
return module
