table.insert(config.spaces, {
  text = "Focused Meeting",
  subText = "People come first.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  blacklist = {'distraction'},
  launch = {'calendar'},
  toggl_proj = config.projects.focused_meetings,
})
