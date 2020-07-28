table.insert(config.spaces, {
  text = "Review",
  subText = "Setup a Things 3 Review Session.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'review',
  toggl_proj = config.projects.planning,
  toggl_desc = "Review",
  blacklist = {'distraction', 'communication'},
})

config.funcs.review = {
    setup = function()
    hs.application.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
    local things = hs.application.find('com.culturedcode.ThingsMac')
    things:selectMenuItem("Hide Sidebar")

    hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
    things:selectMenuItem("New Things Window")
    things:selectMenuItem("Today")

    things:selectMenuItem("New Things Window")
    if things:findMenuItem("Show Sidebar") then
      things:selectMenuItem("Show Sidebar")
    end
    things:selectMenuItem("Inbox")

    hs.layout.apply(
      {
        {"Things", "Inbox", hs.screen.primaryScreen(), hs.layout.left70, 0, 0},
        {"Things", "Today", hs.screen.primaryScreen(), hs.layout.right30, 0, 0}
      }
    )
  end
}
