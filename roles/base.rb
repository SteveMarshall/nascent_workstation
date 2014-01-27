name "base"
description "Common across all machines"

run_list "recipe[mac_os_x::settings]"

default_attributes mac_os_x: {
  settings: {
    sysprefs_general: {
      domain: 'NSGlobalDomain',
      AppleAquaColorVariant: 6,                         # Graphite = 6, Aqua = 1
      AppleHighlightColor: '0.780400 0.815700 0.858800',# Graphite
    },
    sysprefs_desktop_menubar: {
      domain: 'com.apple.systemuiserver',
      menuExtras: [
        '/System/Library/CoreServices/Menu Extras/AirPort.menu',
        '/System/Library/CoreServices/Menu Extras/Clock.menu'
      ],
    },
    sysprefs_dock: {
      domain: 'com.apple.dock',
      magnification: true,
      autohide: true,
      tilesize: 50,
      largesize: 65,
      # TODO: Dock items
    },
  }
}
