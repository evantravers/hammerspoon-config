table.insert(config.spaces, {
  text = "Standup",
  subText = "Run UX Standup. (Shallow)",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  setup = "standup",
  always = {'#planning'},
  never = {'#distraction', '#communication', '#coding'},
  toggl_proj = config.projects.meetings,
  toggl_desc = "UX Standup"
})

config.setup.standup = function()
  hs.urlevent.openURL(hs.settings.get("secrets").standupURL)
  local brave = hs.application('com.brave.Browser')
  brave:focusedWindow():moveOneScreenWest()

  brave:selectMenuItem("New Window")
  hs.urlevent.openURL(hs.settings.get("secrets").standupCall)
  brave:focusedWindow():moveOneScreenEast()
end

