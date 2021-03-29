# Personal Hammerspoon Setup

Intended to live in `~/.hammerspoon`
To install: `git clone git@github.com:evantravers/hammerspoon-config.git ~/.hammerspoon`

## Requirements

- Hyper requires Karabiner-elements, or some way of binding an F19 key (I bind
  left control -> F19)

## Modules

### Autolayout

- Listens to display changes and moves and maximizes windows based on screen
  preferences.

### Brave

- Provides bindings for Brave Browser
    - Focus tab by domain in any window
    - Kill tabs by domain

### Hyper

Moved to [https://github.com/evantravers/Hyper.spoon](https://github.com/evantravers/Hyper.spoon)

- Provides a modal layer for the other plugins, based on F19.
- Supports holding mods with your hyper, unlike most hyper solutions.
- Launch/focus an app.
- Allows an application to use "hyper shortcuts" by passing on
  ⌘+⌥+⌃+⇧+&lt;char&gt;.

### Headspace

Moved to [https://github.com/evantravers/headspace.spoon](https://github.com/evantravers/headspace.spoon)

### Movewindows

My personal bindings for a Moom.app like interface for moving windows around.

- One interesting binding for auto splitting an reference application, moved out to [https://github.com/evantravers/split.spoon](https://github.com/evantravers/split.spoon)

### Secrets

Simple loading of API keys or secret variables into `hs.settings` via
`hs.json`.

### Toggl

Simple toggl client. Used by Headspace.
