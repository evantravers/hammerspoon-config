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
    hs.shortcuts.run("DND On")
    hs.urlevent.openURL("things:///show?id=anytime&filter=@Meazure%20Learning,People")

    if IsDocked() and spoon.ElgatoKey.isConnected() then
      spoon.ElgatoKey:on()
    end
  end,
  teardown = function()
    hs.shortcuts.run("DND Off")
    hs.urlevent.openURL("things:///show?id=today")

    if IsDocked() and spoon.ElgatoKey.isConnected() then
      spoon.ElgatoKey:off()
    end
  end
}
