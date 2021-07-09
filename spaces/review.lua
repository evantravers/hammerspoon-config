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
    {"Things", "Today", hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0},
    {"Obsidian", nil, hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0}
  }
})

Config.funcs.review = {
  setup = function()
    local things = hs.application.find('com.culturedcode.ThingsMac')
    hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
    hs.urlevent.openURL("things:///show?id=today")
    things:selectMenuItem("Hide Sidebar")
    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandname=Periodic%20Notes%3A%20Open%20daily%20note")
  end,
  teardown = function()
    local things = hs.application.find('com.culturedcode.ThingsMac')
    things:selectMenuItem("Update with Things Cloud")
  end
}
