table.insert(Config.spaces, {
  text = "Start",
  subText = "Start work with the minimum distraction",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  launch = {'planning'},
  togglProj = Config.projects.shallow,
  togglDesc = "Morning Prep",
  funcs = 'launch'
})

Config.funcs.launch = {
  setup = function()
    hs.application.launchOrFocusByBundleID("com.toggl.daneel")
  end
}
