table.insert(Config.spaces, {
  text = "Deep",
  subText = "Work deeply on focused work",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  toggl_proj = Config.projects.deep,
  blacklist = {'distraction', 'communication'},
  funcs = 'deep'
})

Config.funcs.deep = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,$High")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
