table.insert(Config.spaces, {
  text = "Leadership",
  subText = "Working on the team, not in the team.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  blacklist = {'distraction'},
  launch = {'calendar'},
  togglProj = Config.projects.leadership,
  intentRequired = true,
  suggestions = hs.settings.get("secrets"),
  funcs = "leadership"
})

Config.funcs.leadership = {
  setup = function()
    hs.urlevent.openURL("obsidian://open?vault=wiki&file=career%2F07%20ProctorU%2FMeazure%20Learning")
    hs.urlevent.openURL("things:///show?id=FmRoB23gESK4AT8dR2zN4J")
  end
}
