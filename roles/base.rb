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
  }
}
