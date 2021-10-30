table.insert(Config.spaces, {
  text = "Collaborative Meeting",
  subText = "Collaborating on a call.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  launch = {'calendar'},
  blacklist = {'distraction'},
  togglProj = Config.projects.meeting,
  funcs = 'agendaFor',
  intentRequired = true,
  intentSuggestions = hs.settings.get("secrets").collaborativeMeetings
})

Config.funcs.agendaFor = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@Meazure%20Learning,People")

    spoon.ElgatoKey:on()
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")

    spoon.ElgatoKey:off()
  end
}
