table.insert(Config.spaces, {
  text = "Review",
  subText = "Setup a Things 3 Review Session.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'review',
  launch = {'planning'},
  togglProj = Config.projects.planning,
  togglDesc = "Review",
  blacklist = {'distraction', 'communication'},
  layouts = {
    {"Things", "Today", hs.screen.primaryScreen():name(), hs.layout.maximized, 0, 0}
  }
})

Config.funcs.review = {
  setup = function()
    local things = hs.application.find('com.culturedcode.ThingsMac')
    hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
    hs.urlevent.openURL("things:///show?id=today")
    things:selectMenuItem("Hide Sidebar")
    hs.urlevent.openURL("obsidian://new?vault=wiki&file=journal%2Fdaily%2F" .. os.date("%Y-%m-%d"))
  end,
  teardown = function()
    local things = hs.application.find('com.culturedcode.ThingsMac')
    things:selectMenuItem("Update with Things Cloud")
  end
}
