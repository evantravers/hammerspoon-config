return {
  ['com.runningwithcrayons.Alfred'] = {
    bundleID = 'com.runningwithcrayons.Alfred',
    localBindings = {'c', 'space', 'o', 'l'}
  },
  ['net.kovidgoyal.kitty'] = {
    bundleID = 'net.kovidgoyal.kitty',
    hyperKey = 'j',
    tags = {'coding'},
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.brave.Browser'] = {
    bundleID = 'com.brave.Browser',
    hyperKey = 'k',
    layouts = {
      {nil, 1, hs.layout.maximized},
      {"Confluence", 1, hs.layout.maximized},
      {"Meet - ", 2, hs.layout.maximized},
    }
  },
  ['org.mozilla.firefox'] = {
    bundleID = 'org.mozilla.firefox',
    hyperKey = 'b',
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.kapeli.dashdoc'] = {
    bundleID = 'com.kapeli.dashdoc',
    hyperKey = 'h',
    tags = {'coding'}
  },
  ['com.microsoft.teams'] = {
    bundleID = 'com.microsoft.teams',
    tags = {'communication'},
    layouts = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.apple.mail'] = {
    bundleID = 'com.apple.mail',
    hyperKey = 'e',
    tags = {'communication', 'distraction'},
    layouts = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.flexibits.fantastical2.mac'] = {
    bundleID = 'com.flexibits.fantastical2.mac',
    hyperKey = 'y',
    localBindings = {']'},
    tags = {'planning', 'review', 'calendar'},
    whitelisted = true,
    layouts = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.apple.finder'] = {
    bundleID = 'com.apple.finder',
    hyperKey = 'f'
  },
  ['com.hnc.Discord'] = {
    bundleID = 'com.hnc.Discord',
    tags = {'distraction'},
    layouts = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.tinyspeck.slackmacgap'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    tags = {'distraction', 'communication'},
    layouts = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.tapbots.Tweetbot3Mac'] = {
    bundleID = 'com.tapbots.Tweetbot3Mac',
    tags = {'distraction', 'socialmedia'},
    localBindings = {'\\'}
  },
  ['com.culturedcode.ThingsMac'] = {
    bundleID = 'com.culturedcode.ThingsMac',
    hyperKey = 't',
    tags = {'planning', 'review', 'tasks'},
    whitelisted = true,
    localBindings = {',', '.'},
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.agiletortoise.Drafts-OSX'] = {
    bundleID = 'com.agiletortoise.Drafts-OSX',
    hyperKey ='d',
    tags = {'review', 'writing', 'research', 'notes'},
    whitelisted = true,
    localBindings = {'x', ';'}
  },
  ['com.toggl.toggldesktop.TogglDesktop'] = {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    localBindings = {'p'}
  },
  ['com.ideasoncanvas.mindnode.macos'] = {
    bundleID = 'com.ideasoncanvas.mindnode.macos',
    tags = {'research'},
    hyperKey = 'u',
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.apple.MobileSMS'] = {
    bundleID = 'com.apple.MobileSMS',
    hyperKey = 'q',
    tags = {'communication', 'distraction'},
    layouts = {
      {nil, 2, hs.layout.right30}
    }
  },
  ['com.valvesoftware.steam'] = {
    bundleID = 'com.valvesoftware.steam',
    tags = {'distraction'}
  },
  ['net.battle.app'] = {
    bundleID = 'net.battle.app',
    tags = {'distraction'}
  },
  ['com.spotify.client'] = {
    bundleID = 'com.spotify.client'
  },
  ['com.figma.Desktop'] = {
    bundleID = 'com.figma.Desktop',
    tags = {'design'},
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.reederapp.5.macOS'] = {
    bundleID = 'com.reederapp.5.macOS',
    hyperKey = 'n',
    tags = {'distraction'},
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['md.obsidian'] = {
    bundleID = 'md.obsidian',
    hyperKey = 'g',
    tags = {'research', 'notes'},
    layouts = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['us.zoom.xos'] = {
    bundleID = 'us.zoom.xos',
    layouts = {
      {"Zoom Meeting", 2, hs.layout.maximized}
    }
  },
  ['org.whispersystems.signal-desktop'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    tags = {'distraction', 'communication'}
  }
}
