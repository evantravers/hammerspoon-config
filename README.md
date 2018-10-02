# Personal Hammerspoon Setup

Intended to live in `~/.hammerspoon`
To install: `git clone git@github.com:evantravers/hammerspoon.git ~/.hammerspoon`

## Requirements

- Karabiner-elements, or some way of binding an F19 key (I bind left control ->
  F19)

## Features

### hyperkey

- jump to app via config in `init.lua`
- reload config
- force autolayout

### autolayout

- listens to display changes and moves and maximizes windows based on screen
  preferences.

### keyboardhacks

- provide an emulated `ESC` key via doubletap on left control (which I usually
  have on capslock.)
- TODO: work with other keys

### pomodoro timer
TODO:

- on start should close list of distractions
- on pause/stop should open distractions back up
- ideally changes the /etc/hosts too
