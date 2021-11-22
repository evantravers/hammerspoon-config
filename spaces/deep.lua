table.insert(Config.spaces, {
  text = "Deep",
  subText = "Work deeply on focused work",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  togglProj = Config.projects.deep,
  blacklist = {'distraction', 'communication'},
  intentRequired = true,
  funcs = 'deep'
})

Config.funcs.deep = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@Meazure%20Learning,$High")
    hs.urlevent.openURL("shortcuts://run-shortcut?name=Deep%20Focus")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
    hs.urlevent.openURL("shortcuts://run-shortcut?name=Leave%20Deep%20Focus")
  end
}
