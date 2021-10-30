table.insert(Config.spaces, {
  text = "Work is done.",
  subText = "End of the day, or going to lunch.",
  funcs = "shutdown"
})

Config.funcs.shutdown = {
  setup = function()
    spoon.Headspace.stopToggl()

    -- shut down everything
    local dockedApplications =
      hs.fnutils.filter(hs.application.runningApplications(), function(app)
        return app:kind() == 1
      end)

    hs.fnutils.map(dockedApplications, function(app)
      app:kill()
    end)

    if IsDocked() then
      spoon.ElgatoKey:off()
    end

    -- screensaver
    hs.caffeinate.startScreensaver()
  end
}
