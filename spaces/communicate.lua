table.insert(Config.spaces, {
  text = "Communication",
  subText = "Intentionally engage with Slack and Email.",
  image = hs.image.imageFromAppBundle('com.apple.mail'),
  whitelist = {'communication'},
  launch = {'communication'},
  togglProj = Config.projects.communication,
  funcs = 'agendaFor'
})

Config.funcs.agendaFor = {
  setup = function()
    hs.urlevent.openURL("things:///show?id=anytime&filter=@Meazure%20Learning")
  end,
  teardown = function()
    hs.urlevent.openURL("things:///show?id=today")
  end
}
