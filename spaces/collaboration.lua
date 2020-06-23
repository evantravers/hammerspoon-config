table.insert(config.spaces, {
  text = "Collaborative Meeting",
  subText = "Collaborating on a call.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  launch = {'calendar'},
  blacklist = {'distraction'},
  toggl_proj = config.projects.meetings
})
