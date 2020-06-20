table.insert(config.spaces, {
  text = "Write",
  subText = "You are allowed to do anything you want, as long as you write.",
  image = hs.image.imageFromAppBundle('com.agiletortoise.Drafts-OSX'),
  toggl_proj = config.projects.deep,
  only = {'#writing'},
  setup = 'distractionless_writing'
})

config.setup.distractionless_writing = function()
  local drafts = hs.application("Drafts")

  drafts:selectMenuItem("Hide Draft List")
  drafts:selectMenuItem("Hide Filters")
  drafts:selectMenuItem("Hide Action List")
  drafts:selectMenuItem("Hide Toolbar")
  drafts:selectMenuItem("Hide Tag Entry")
  drafts:selectMenuItem("Hide Action Bar")
  -- if drafts:findMenuItem("Typewriter Scrolling").ticked then
  --   drafts:selectMenuItem("Typewriter Scrolling")
  -- end
end
