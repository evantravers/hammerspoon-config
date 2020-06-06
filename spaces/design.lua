table.insert(config.spaces, {
  text = "Design",
  subText = "Iterating and collaborating on Design artifacts in Figma",
  image = hs.image.imageFromAppBundle('com.figma.Desktop'),
  only = {'#design'},
  toggl_proj = config.projects.design
})
