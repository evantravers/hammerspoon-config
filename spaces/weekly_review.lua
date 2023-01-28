table.insert(Config.spaces, {
  text = "Weekly Review",
  subText = "Groom and evaluate projects in Things 3.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'weeklyreview',
  togglProj = Config.projects.planning,
  togglDesc = "Weekly Review",
  launch = {'planning'},
  blacklist = {'distraction', 'communication'},
  layouts = {
    {"Obsidian", nil, hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0},
    {"Things", nil, hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0},
    {"Things", "Today", hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0},
    {"Things", "Weekly Review", hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0}
  }
})

Config.funcs.weeklyreview = {
  setup = function()
    hs.shortcuts.run("Weekly Review")

    local things = hs.application.find('com.culturedcode.ThingsMac')
    hs.fnutils.imap(things:allWindows(), function(v) v:close() end)
    hs.urlevent.openURL("things:///show?id=inbox")
    things:selectMenuItem("Show Sidebar")

    things:selectMenuItem("New Things Window")
    hs.urlevent.openURL("things:///show?id=today")
    things:selectMenuItem("Hide Sidebar")

    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandname=Periodic%20Notes%3A%20Open%20weekly%20note")
  end
}
