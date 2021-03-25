return {
  ['com.runningwithcrayons.Alfred'] = {
    bundleID = 'com.runningwithcrayons.Alfred',
    local_bindings = {'c', 'space', 'o', 'l'}
  },
  ['net.kovidgoyal.kitty'] = {
    bundleID = 'net.kovidgoyal.kitty',
    hyper_key = 'j',
    tags = {'coding'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.brave.Browser'] = {
    bundleID = 'com.brave.Browser',
    hyper_key = 'k',
    rules = {
      {nil, 1, hs.layout.maximized},
      {"Confluence", 1, hs.layout.maximized},
      {"Meet - ", 2, hs.layout.maximized},
    }
  },
  ['org.mozilla.firefox'] = {
    bundleID = 'org.mozilla.firefox',
    hyper_key = 'b',
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.kapeli.dashdoc'] = {
    bundleID = 'com.kapeli.dashdoc',
    hyper_key = 'h',
    tags = {'coding'}
  },
  ['com.microsoft.teams'] = {
    bundleID = 'com.microsoft.teams',
    hyper_key = 'i',
    tags = {'communication'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.apple.mail'] = {
    bundleID = 'com.apple.mail',
    hyper_key = 'e',
    tags = {'communication', 'distraction'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.flexibits.fantastical2.mac'] = {
    bundleID = 'com.flexibits.fantastical2.mac',
    hyper_key = 'y',
    local_bindings = {']'},
    tags = {'planning', 'review', 'calendar'},
    whitelisted = true,
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.apple.finder'] = {
    bundleID = 'com.apple.finder',
    hyper_key = 'f'
  },
  ['com.hnc.Discord'] = {
    bundleID = 'com.hnc.Discord',
    tags = {'distraction'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.tinyspeck.slackmacgap'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    tags = {'distraction', 'communication'},
    rules = {
      {nil, 2, hs.layout.maximized}
    }
  },
  ['com.tapbots.Tweetbot3Mac'] = {
    bundleID = 'com.tapbots.Tweetbot3Mac',
    tags = {'distraction', 'socialmedia'},
    local_bindings = {'\\'}
  },
  ['com.culturedcode.ThingsMac'] = {
    bundleID = 'com.culturedcode.ThingsMac',
    hyper_key = 't',
    tags = {'planning', 'review', 'tasks'},
    whitelisted = true,
    local_bindings = {',', '.'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.agiletortoise.Drafts-OSX'] = {
    bundleID = 'com.agiletortoise.Drafts-OSX',
    hyper_key ='d',
    tags = {'review', 'writing', 'research', 'notes'},
    whitelisted = true,
    local_bindings = {'x', ';'}
  },
  ['com.toggl.toggldesktop.TogglDesktop'] = {
    bundleID = 'com.toggl.toggldesktop.TogglDesktop',
    local_bindings = {'p'}
  },
  ['com.ideasoncanvas.mindnode.macos'] = {
    bundleID = 'com.ideasoncanvas.mindnode.macos',
    tags = {'research'},
    hyper_key = 'u',
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.apple.MobileSMS'] = {
    bundleID = 'com.apple.MobileSMS',
    hyper_key = 'q',
    tags = {'communication', 'distraction'},
    rules = {
      {nil, 2, hs.layout.right30}
    }
  },
  ['com.valvesoftware.steam'] = {
    bundleID = 'com.valvesoftware.steam',
    tags = {'distraction'}
  },
  ['com.spotify.client'] = {
    bundleID = 'com.spotify.client'
  },
  ['com.figma.Desktop'] = {
    bundleID = 'com.figma.Desktop',
    tags = {'design'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['com.reederapp.5.macOS'] = {
    bundleID = 'com.reederapp.5.macOS',
    hyper_key = 'n',
    tags = {'distraction'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['md.obsidian'] = {
    bundleID = 'md.obsidian',
    hyper_key = 'g',
    tags = {'research', 'notes'},
    rules = {
      {nil, 1, hs.layout.maximized}
    }
  },
  ['us.zoom.xos'] = {
    bundleID = 'us.zoom.xos',
    rules = {
      {"Zoom Meeting", 2, hs.layout.maximized}
    }
  },
  ['org.whispersystems.signal-desktop'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    tags = {'distraction', 'communication'}
  }
}
