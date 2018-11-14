# Personal Hammerspoon Setup

Intended to live in `~/.hammerspoon`
To install: `git clone git@github.com:evantravers/hammerspoon.git ~/.hammerspoon`

## Requirements

- Karabiner-elements, or some way of binding an F19 key (I bind left control ->
  F19)

## Features

### hyperkey

- jump to app via config in `init.lua`
- provides a modal layer for the other plugins

### autolayout

- listens to display changes and moves and maximizes windows based on screen
  preferences.

### pomodoro timer
- on start should close list of distractions
- on pause/stop should open distractions back up
- TODO: ideally changes the /etc/hosts too
- TODO: menubar timer?
- TODO: slack set away rather than close?
- TODO: OSX DND mode
