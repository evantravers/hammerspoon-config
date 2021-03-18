table.insert(Config.spaces, {
  text = "Focused Meeting",
  subText = "People come first.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  blacklist = {'distraction'},
  launch = {'calendar'},
  toggl_proj = Config.projects.focused_meeting,
  intent_required = true,
  suggestions = hs.settings.get("secrets").focused_meetings
})

