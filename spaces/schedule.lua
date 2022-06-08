table.insert(Config.spaces, {
  text = "Time Block",
  subText = "Schedule tasks into your day.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  funcs = 'focus_budget',
  launch = {'planning'},
  blacklist = {'distraction', 'communication'},
  togglProj = Config.projects.planning,
  togglDesc = "Focus Budget",
  layouts = {
    {"Fantastical", nil, hs.screen.primaryScreen():name(), hs.layout.left70, 0, 0},
    {"Things", nil, hs.screen.primaryScreen():name(), hs.layout.right30, 0, 0}
  }
})

Config.funcs.focus_budget = {
  setup = function()
    if tonumber(os.date("%H")) > 15 then
      if os.date("%a") == "Sun" or os.date("%a") == "Sat" or os.date("%a") == "Fri" then
        hs.urlevent.openURL("things:///show?id=upcoming&filter=%40Proctoru%2CEstimates")
      else
        hs.urlevent.openURL("things:///show?id=tomorrow&filter=%40Proctoru%2CEstimates")
      end
    else
      hs.urlevent.openURL("things:///show?id=today&filter=%40Proctoru%2CEstimates")
    end

    local things = hs.application.find('com.culturedcode.ThingsMac')
    local fantastical = hs.application.find('com.flexibits.fantastical2.mac')

    local upcoming = things:focusedWindow()
    upcoming:application():selectMenuItem("Hide Sidebar")

    local cal = fantastical:focusedWindow()
    cal:application():selectMenuItem("Hide Sidebar")
    cal:application():selectMenuItem("Focus Budget")
    cal:application():selectMenuItem("By Week")
  end,
  teardown = function()
    local fantastical = hs.application.find('com.flexibits.fantastical2.mac')
    fantastical:selectMenuItem("Show Sidebar")
    fantastical:selectMenuItem("Daily Focus")
  end
}
