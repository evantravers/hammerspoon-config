local module = {}

local function appsTaggedWith(tag)
  return hs.fnutils.filter(config.applications, function(app)
    return app.tags and hs.fnutils.contains(app.tags, tag)
  end)
end

-- launches either by tag or by bundle id from a list
module.launch = function(list)
  hs.fnutils.map(list, function(tag_or_bundle)
    hs.fnutils.map(appsTaggedWith(tag_or_bundle), function(app)
      hs.application.launchOrFocusByBundleID(app.bundleID)
    end)
  end)
end

module.kill = function(list)
  hs.fnutils.map(list, function(tag_or_bundle)
    hs.fnutils.map(appsTaggedWith(tag_or_bundle), function(app)
      hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
        app:kill()
      end)
    end)
  end)
end

module.appsTaggedWith = appsTaggedWith
return module
