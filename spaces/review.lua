table.insert(config.spaces, {
  text = "Review",
  subText = "Setup a Things 3 Review Session.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'review',
  launch = {'planning'},
  toggl_proj = config.projects.planning,
  toggl_desc = "Review",
  blacklist = {'distraction', 'communication'},
  layouts = {
    {"Things", "Inbox", hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0},
    {"Things", "Today", hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0}
  }
})

config.funcs.review = {
  setup = function()
    local things = hs.application.find('com.culturedcode.ThingsMac')
    hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
    hs.urlevent.openURL("things:///show?id=inbox")
    things:selectMenuItem("Show Sidebar")

    things:selectMenuItem("New Things Window")
    hs.urlevent.openURL("things:///show?id=today")
    things:selectMenuItem("Hide Sidebar")
  end,
  teardown = function()
    local things = hs.application.find('com.culturedcode.ThingsMac')
    things:selectMenuItem("Update with Things Cloud")
  end
}
