table.insert(Config.spaces, {
  text = "Work is done.",
  subText = "End of the day, or going to lunch.",
  funcs = "shutdown"
})

Config.funcs.shutdown = {
  setup = function()
    spoon.Headspace.stopToggl()

    -- shut down everything
    hs.fnutils.map(hs.application.runningApplications(), function(app)
      app:kill()
    end)

    -- screensaver
    hs.caffeinate.startScreensaver()
  end,
  teardown = function()
    hs.application.launchOrFocusByBundleID("com.toggl.toggldesktop.TogglDesktop")
  end
}
