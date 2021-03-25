if hs.application.pathForBundleID('com.figma.Desktop') then
  table.insert(Config.spaces, {
    text = "Design",
    subText = "Iterating on Design artifacts in Figma",
    image = hs.image.imageFromAppBundle('com.figma.Desktop'),
    whitelist = {'design', 'research'},
    togglProj = Config.projects.design,
    intentRequired = true
  })
end
