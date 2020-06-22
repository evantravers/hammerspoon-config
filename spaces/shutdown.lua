local toggl = require('toggl')

table.insert(config.spaces, {
  text = "Shutdown",
  subText = "Work is done",
  setup = "shutdown"
})

config.setup.shutdown = function()
  toggl.stop_timer()
  hs.settings.clear("headspace")

  -- shut down everything
  hs.fnutils.map(config.applications, function(app)
    hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(a) a:kill() end)
  end)
end
