# MoveWindows

MoveWindows is a "moom" style window mover, originally written by
[@tmiller](https://github.com/tmiller/) that I've adapted over the years.

At it's core, MoveWindows provides a sane set of default vim-style keybindings
to move windows around, but you can override anything at any point.

Quickstart, setting the mode to `⌘+⇧+M`:

```lua
hs.loadSpoon('MoveWindows')
  :start()
  :bindHotKeys({toggle = {{"command", "shift"}, "m"}})
```

If you wish to adjust the bindings and "grid", simply set or extend
MoveWindows.grid before calling `MoveWindows:start()`.

```lua
MoveWindows = hs.loadSpoon('MoveWindows')
MoveWindows.grid = {
  { key='j', unit=hs.geometry.rect(0, 0.5, 1, 0.5) },
  { key='space', unit=hs.layout.maximized }
}

MoveWindows
  :start()
  :bindHotKeys({toggle = {{"command", "shift"}, "m"}})
```

Because MoveWindows is simply a wrapper around
[hs.hotkey.modal](https://www.hammerspoon.org/docs/hs.hotkey.modal), you can
expand it's functionality with other Spoons like
[Split.spoon](https://github.com/evantravers/Split.spoon), or include your own
functionality:

```lua
hs.loadSpoon('MoveWindows')

MoveWindows = spoon.MoveWindows
MoveWindows
  :start()
  :bind('', ',', function()
    hs.window.focusedWindow()
      :application()
      :selectMenuItem("Tile Window to Left of Screen")
    MoveWindows:exit()
  end)
  :bind('', '.', function()
    hs.window.focusedWindow()
      :application()
      :selectMenuItem("Tile Window to Right of Screen")
    MoveWindows:exit()
  end)
  :bind('', 'v', function()
    spoon.Split.split()
    MoveWindows:exit()
  end)
  :bindHotKeys({toggle = {{"command", "shift"}, "m"}})
```

If you want to use [Hyper.spoon](https://github.com/evantravers/Hyper.spoon),
you can just access `MoveWindows:toggle()` directly:

```lua
Hyper:bind({}, 'm', function() MoveWindows:toggle() end)
```
