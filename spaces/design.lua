if hs.application.pathForBundleID('com.figma.Desktop') then
  table.insert(config.spaces, {
    text = "Design",
    subText = "Iterating and collaborating on Design artifacts in Figma",
    image = hs.image.imageFromAppBundle('com.figma.Desktop'),
    only = {'#design', '#research'},
    toggl_proj = config.projects.design
  })
end
