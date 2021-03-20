table.insert(Config.spaces, {
  text = "Focused Meeting",
  subText = "People come first.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  blacklist = {'distraction'},
  launch = {'calendar'},
  togglProj = Config.projects.focused_meeting,
  intentRequired = true,
  suggestions = hs.settings.get("secrets").focused_meetings
})

