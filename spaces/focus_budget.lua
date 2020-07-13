table.insert(config.spaces, {
  text = "Plan a Focus Budget",
  subText = "Setup Things 3 and Fantastical",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  funcs = 'focus_budget',
  blacklist = {'distraction', 'communication'},
  toggl_proj = config.projects.planning,
  toggl_desc = "Focus Budget",
})

config.funcs.focus_budget = {
  setup = function()
    hs.application.launchOrFocusByBundleID('com.culturedcode.ThingsMac')
    hs.application.launchOrFocusByBundleID('com.flexibits.fantastical2.mac')

    local things = hs.application.find('com.culturedcode.ThingsMac')
    local fantastical = hs.application.find('com.flexibits.fantastical2.mac')

    local today = things:focusedWindow()
    today:application():selectMenuItem("Hide Sidebar")
    today:application():selectMenuItem("Today")

    local cal = fantastical:focusedWindow()
    cal:application():selectMenuItem("Hide Sidebar")
    cal:application():selectMenuItem("By Week")

    hs.layout.apply(
    {
      {"Fantastical", nil, hs.screen.primaryScreen(), hs.layout.left70, 0, 0},
      {"Things", nil, hs.screen.primaryScreen(), hs.layout.right30, 0, 0}
    }
    )
  end
}
