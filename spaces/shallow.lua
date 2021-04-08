table.insert(Config.spaces, {
  text = "Shallow",
  subText = "Work on low intensity tasks.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  togglProj = Config.projects.shallow,
  funcs = 'shallow',
  intentRequired = true
})

Config.funcs.shallow = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@Meazure%20Learning,$Low")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
