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
    hs.urlevent.openURL("obsidian://open?vault=wiki&file=templates%2Frituals%2FWorkday%20Shutdown")
    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandid=workspace%253Aclose-others")
    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandid=workspace%253Asplit-vertical")
    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandid=editor%253Afocus-right")
    hs.urlevent.openURL("obsidian://advanced-uri?vault=wiki&commandid=periodic-notes%253Aopen-daily-note")
  end,
  teardown = function()
  end
}
