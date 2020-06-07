local module = {}

module.start = function(config_table)
  module.config = config_table
end

module.appsTaggedWith = function(tag)
  return hs.fnutils.filter(module.config, function(app)
    return app.tags and hs.fnutils.contains(app.tags, tag)
  end)
end

-- launches either by tag or by bundle id from a list
module.launch = function(list)
  hs.fnutils.map(list, function(tag)
    hs.fnutils.map(module.appsTaggedWith(tag), function(app)
      hs.application.launchOrFocusByBundleID(app.bundleID)
    end)
  end)
end

module.kill = function(list)
  hs.fnutils.map(list, function(tag)
    hs.fnutils.map(module.appsTaggedWith(tag), function(app)
      hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
        app:kill()
      end)
    end)
  end)
end

return module
