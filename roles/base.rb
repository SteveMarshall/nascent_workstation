name "base"
description "Common across all machines"

run_list(
  "recipe[nascent_workstation::homebrew]",
  "recipe[nascent_workstation::perl]",
  "recipe[nascent_workstation::sysprefs]",
  "recipe[mac_os_x::settings]",
  "recipe[virtualbox]",
  "recipe[vagrant]",
)

default_attributes(
  homebrew: {
    packages: {
      'bash-completion' => nil,
      'cpanminus'       => nil,
      'hub'             => nil,
    }
  },
  mac_os_x: {
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
      sysprefs_languages: {
        domain: 'NSGlobalDomain',
        AppleLanguages: ['en-GB'],                        # Preferred languages
        AppleLocale: 'en_GB',                             # Region
        AppleMetricUnits: true,                           # Metric measurements
        AppleICUForce12HourTime: false                    # 24 hour clock
        # TODO: restart SystemUIServer on AppleLocale
      },
      sysprefs_security_screensaver: {
        domain: 'com.apple.screensaver',
        askForPassword: true,                             # Require password
        askForPasswordDelay: 5,                           # … 5 seconds after screensaver begins
      },
      sysprefs_security_firewall: {
        domain: '/Library/Preferences/com.apple.alf',
        globalstate: 1,                                   # Enable firewall
        # TODO: Reload firewall?
        # launchctl unload /System/Library/LaunchAgents/com.apple.alf.useragent.plist
        # launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist
        # launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist
        # launchctl load /System/Library/LaunchAgents/com.apple.alf.useragent.plist
      },
      # TODO: Sysprefs/Security/Allow apps from MAS & ID'd devs
      # TODO: Sysprefs/Security/FileVault
      # TODO: Sysprefs/Security/Privacy
      sysprefs_keyboard: {
        domain: 'NSGlobalDomain',
        AppleKeyboardUIMode: 2,                           # Full keyboard access
        NSUserReplacementItems: {
          '(c)' => '©',
          '(r)' => '®',
          '(p)' => '℗',
          'TM' => '™',
          'c/o' => '℅',
          '...' => '…',
          '1/2' => '½',
          '1/3' => '⅓',
          '2/3' => '⅔',
          '1/4' => '¼',
          '3/4' => '¾',
          '1/8' => '⅛',
          '3/8' => '⅜',
          '5/8' => '⅝',
          '7/8' => '⅞',
          '(cmd)' => '⌘',
          '(opt)' => '⌥',
          '(ctrl)' => '⌃',
          '(shift)' => '⇧',
          '(caps)' => '⇪',
          '(eject)' => '⏏',
          '(up)' => '↑',
          '(down)' => '↓',
          '(left)' => '←',
          '(right)' => '→',
          '(mult)' => '×',
          '(tab)' => '⇥',
          '(enter)' => '⏎',
          # TODO: Add emoji replacements, per github.com/gregburek/github-emoji-expansion-in-osx
        }.map { |replace, with|
          # HACK: Use XML plist format, because json doesn't handle `on` properly
          "<dict>
            <key>on</key>
            <integer>1</integer>
            <key>replace</key>
            <string>#{replace}</string>
            <key>with</key>
            <string>#{with}</string>
          </dict>"
        },
      },
    }
  },
  vagrant: {
    url: 'https://dl.bintray.com/mitchellh/vagrant/Vagrant-1.4.3.dmg',
    checksum: 'e7ff13b01d3766829f3a0c325c1973d15b589fe1a892cf7f857da283a2cbaed1',
    plugins: [
      'vagrant-berkshelf',
      'vagrant-omnibus',
    ]
  },
)
