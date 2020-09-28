# Personal Hammerspoon Setup

Intended to live in `~/.hammerspoon`
To install: `git clone git@github.com:evantravers/hammerspoon-config.git ~/.hammerspoon`

## Requirements

- Hyper requires Karabiner-elements, or some way of binding an F19 key (I bind
  left control -> F19)

## Modules

### Airpods

Using a script from
[here](https://gist.githubusercontent.com/daGrevis/79b27b9c156ba828ad52976a118b29e0/raw/0e77383f4eb9301527caac3f0b71350e9499210b/init.lua),
connect and disconnect my AirPods.

### Autolayout

- Listens to display changes and moves and maximizes windows based on screen
  preferences.

### Brave

- Provides bindings for Brave Browser
    - Focus tab by domain in any window
    - Kill tabs by domain
    - Kill tabs by tag

### Hyper

- Provides a modal layer for the other plugins, based on F19.
- Supports holding mods with your hyper, unlike most hyper solutions.
- Launch/focus an app.
- Allows an application to use "hyper shortcuts" by passing on
  ⌘+⌥+⌃+⇧+&lt;char&gt;.

### Headspace

Tool for configuring custom layouts and workspaces.

- `hs.chooser` UI for picking a space.
- Supports time-tracking via Toggl.
- Launch or kill applications and tabs by tag.
- Block killed application's Hyper shortcuts until the space is changed.

### Movewindows

My personal bindings for a Moom.app like interface for moving windows around.

- One interesting binding for auto splitting an reference application

### Secrets

Simple loading of API keys or secret variables into `hs.settings` via
`hs.json`.

### Toggl

Simple toggl client. Used by Headspace.
