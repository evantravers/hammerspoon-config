table.insert(Config.spaces, {
  text = "Leadership",
  subText = "Working on the team, not in the team.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  blacklist = {'distraction'},
  launch = {'calendar'},
  togglProj = Config.projects.leadership,
  intentRequired = true,
  suggestions = hs.settings.get("secrets")
})

