table.insert(config.spaces, {
  text = "Shallow",
  subText = "Work on low intensity tasks.",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  toggl_proj = config.projects.shallow,
  funcs = 'shallow'
})

config.funcs.shallow = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,$Low")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
