table.insert(config.spaces, {
  text = "Write",
  subText = "You are allowed to do anything you want, as long as you write.",
  image = hs.image.imageFromAppBundle('com.agiletortoise.Drafts-OSX'),
  toggl_proj = config.projects.deep,
  whitelist = {'writing'},
  funcs = 'distractionless_writing'
})

config.funcs.distractionless_writing = {
  setup = function()
    hs.application.launchOrFocusByBundleID('com.agiletortoise.Drafts-OSX')
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
