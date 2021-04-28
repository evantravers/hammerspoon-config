table.insert(Config.spaces, {
  text = "Write",
  subText = "You are allowed to do anything you want, as long as you write.",
  image = hs.image.imageFromAppBundle('com.agiletortoise.Drafts-OSX'),
  togglProj = Config.projects.deep,
  whitelist = {'writing'},
  launch = {'writing'},
  funcs = 'distractionless_writing',
  intentRequired = true
})

Config.funcs.distractionless_writing = {
  setup = function()
    hs.timer.waitWhile(
    function()
      return not hs.application.get('com.agiletortoise.Drafts-OSX'):isFrontmost()
    end,
    function()
      local drafts = hs.application("Drafts")
      drafts:selectMenuItem("Enable Minimal Mode")
      drafts:selectMenuItem("Hide Toolbar")
      drafts:selectMenuItem("Hide Tag Entry")

      drafts
      :mainWindow()
      :setFullScreen(true)
    end
    )
  end,
  teardown = function()
    local drafts = hs.application("Drafts")
    drafts:selectMenuItem("Disable Minimal Mode")

    drafts
    :mainWindow()
    :setFullScreen(false)
  end
}
