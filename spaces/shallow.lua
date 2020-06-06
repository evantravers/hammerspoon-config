table.insert(config.spaces, {
  text = "Shallow",
  subText = "Work on low intensity tasks",
  image = hs.image.imageFromAppBundle('com.culturedcode.ThingsMac'),
  setup = 'shallow'
})

config.setup.shallow = function()
  hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,$Low")
end
