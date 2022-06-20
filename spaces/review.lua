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
    {"Obsidian", nil, hs.screen.primaryScreen():name(), hs.layout.maximized, 0, 0}
  }
})

Config.funcs.review = {
  setup = function()
    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandname=Periodic%20Notes%3A%20Open%20daily%20note")
  end,
  teardown = function()
  end
}
