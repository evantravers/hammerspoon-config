table.insert(config.spaces, {
  text = "Meetings",
  subText = "Collaborating and catching up. (Shallow)",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  never = {'#distraction'},
  always = {'#calendar'},
  toggl_proj = config.projects.meetings,
})
