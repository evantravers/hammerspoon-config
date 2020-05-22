local fn = require('hs.fnutils')

module = {}

module.isTag = function(tag_or_bundle)
  return string.find(tag_or_bundle, '#') == 1
end

module.appsTaggedWith = function(tag)
  return fn.filter(config.applications, function(app)
    return app.tags and fn.contains(app.tags, tag_or_bundle)
  end)
end

-- launches either by tag or by bundle id from a list
module.launch = function(list)
  fn.map(list, function(tag_or_bundle)
    if module.isTag(tag_or_bundle) then -- tag
      fn.map(module.appsTaggedWith(tag_or_bundle), function(app)
        hs.application.launchOrFocusByBundleID(app.bundleID)
      end)
    else -- bundle
      hs.application.launchOrFocusByBundleID(tag_or_bundle)
    end
  end)
end

module.kill = function(list)
  fn.map(list, function(tag_or_bundle)
    if module.isTag(tag_or_bundle) then -- tag
      fn.map(module.appsTaggedWith(tag_or_bundle), function(app)
        fn.map(hs.application.applicationsForBundleID(app.bundleID), function(app)
          app:kill()
        end)
      end)
    else -- bundle
      fn.map(hs.application.applicationsForBundleID(tag_or_bundle), function(app)
        app:kill()
      end)
    end
  end)
end

return module
