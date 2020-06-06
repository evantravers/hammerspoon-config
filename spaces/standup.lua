table.insert(config.spaces, {
  text = "Standup",
  subText = "Run UX Standup",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  setup = "standup",
  always = {'#planning'},
  never = {'#distraction', '#communication', '#coding'},
  toggl_proj = config.projects.meetings,
  toggl_desc = "UX Standup"
})

config.setup.standup = function()
  hs.urlevent.openURL(hs.settings.get("standupURL"))
  hs.urlevent.openURL(hs.settings.get("standupCall"))
end

