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
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
