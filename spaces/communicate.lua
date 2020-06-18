table.insert(config.spaces, {
  text = "Communicate",
  subText = "Intentionally engage with Slack and Email (Shallow)",
  image = hs.image.imageFromAppBundle('com.tinyspeck.slackmacgap'),
  always = {'#communication'},
  toggl_proj = config.projects.communications,
  setup = 'agendaFor'
})

config.setup.agendaFor = function()
  hs.urlevent.openURL("things:///show?id=anytime&filter=@ProctorU,Agenda%20For")
end
