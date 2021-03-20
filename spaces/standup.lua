table.insert(Config.spaces, {
  text = "Standup",
  subText = "Run UX Standup.",
  image = hs.image.imageFromAppBundle('com.flexibits.fantastical2.mac'),
  funcs = "standup",
  launch = {'planning'},
  blacklist = {'distraction', 'coding'},
  togglProj = Config.projects.meeting,
  togglDesc = "UX Standup"
})

Config.funcs.standup = {
  setup = function()
    hs.urlevent.openURL(hs.settings.get("secrets").standupURL)
    local brave = hs.application('com.brave.Browser')
    brave:focusedWindow():moveOneScreenWest()
  end
}
