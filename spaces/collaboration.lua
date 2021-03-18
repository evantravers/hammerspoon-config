table.insert(Config.spaces, {
  text = "Collaborative Meeting",
  subText = "Collaborating on a call.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  launch = {'calendar'},
  blacklist = {'distraction'},
  toggl_proj = Config.projects.meeting,
  funcs = 'agendaFor',
  intent_required = true,
  suggestions = hs.settings.get("secrets").collaborative_meetings
})

Config.funcs.agendaFor = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,!AgendaFor")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
