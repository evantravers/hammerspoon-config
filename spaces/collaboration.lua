table.insert(config.spaces, {
  text = "Collaborative Meeting",
  subText = "Collaborating on a call, or a standup.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  launch = {'calendar'},
  blacklist = {'distraction'},
  toggl_proj = config.projects.meeting
})
