table.insert(config.spaces, {
  text = "Collaborative Meeting",
  subText = "Collaborating on a call.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  launch = {'calendar'},
  blacklist = {'distraction'},
  toggl_proj = config.projects.meeting,
  funcs = 'agendaFor'
})

config.funcs.agendaFor = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,!AgendaFor")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
