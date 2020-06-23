table.insert(config.spaces, {
  text = "Deep",
  subText = "Work deeply on focused work",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  toggl_proj = config.projects.deep,
  blacklist = {'distraction', 'communication'},
  setup = 'deep'
})

config.setup.deep = function()
  hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,$High")
end
