-- local toggl = require('toggl')

table.insert(Config.spaces, {
  text = "Work is done.",
  subText = "End of the day, or going to lunch.",
  funcs = "shutdown"
})

Config.funcs.shutdown = {
  setup = function()
    -- toggl.stop_timer()
    hs.settings.clear("headspace")

    -- shut down everything
    hs.fnutils.map(Config.applications, function(app)
      hs.fnutils.map(hs.application.applicationsForBundleID(app.bundleID), function(a) a:kill() end)
    end)

    -- screensaver
    hs.caffeinate.startScreensaver()
  end,
  teardown = function()
    hs.application.launchOrFocusByBundleID("com.toggl.toggldesktop.TogglDesktop")
  end
}
