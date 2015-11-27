name "base"
description "Common across all machines"

run_list(
  "recipe[homebrew::install_taps]",
  "recipe[homebrew::install_casks]",
  "recipe[homebrew::install_formulas]",
  "recipe[nascent_workstation::apps]",
  "recipe[nascent_workstation::home]",
  "recipe[nascent_workstation::perl]",
  "recipe[nascent_workstation::sysprefs]",
  "recipe[mac_os_x::settings]",
  "recipe[vagrant::install_plugins]",
)

default_attributes(
  apps: {
    Messages: {
      symlinks: {
        "#{ENV['HOME']}/Library/Messages" => "#{ENV['HOME']}/Dropbox/Library/Messages",
      },
    },
    TextMate: {
      symlinks: {
        "#{ENV['HOME']}/bin/mate"                                          => "#{ENV['HOME']}/Applications/TextMate.app/Contents/Resources/mate",
        "#{ENV['HOME']}/Library/Application Support/Avian"                 => "#{ENV['HOME']}/Dropbox/Library/Application Support/Avian",
        "#{ENV['HOME']}/Library/Application Support/TextMate"              => "#{ENV['HOME']}/Dropbox/Library/Application Support/TextMate",
        "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist" => "#{ENV['HOME']}/Dropbox/Library/Preferences/com.macromates.textmate.plist",
      },
      settings: {
        domain: 'com.macromates.TextMate.preview',
        fileBrowserStyle: 'SourceList'
      },
    },
  },
  dashboard: {
    widgets: {
      "Delivery Status"   => "http://files.junecloud.com/delivery-status-6.0.zip",
    }
  },
  home: {
    directories: [
      'Applications',
      'Development',
      'Virtual Machines',
    ],
  },
  homebrew: {
    formulas: [
      'bash-completion',
      'hub',
    ],
    casks: [
      'virtualbox',
      'vagrant',
      'mercurymover',
      'choosy',
      'dropbox',
      'textmate',
    ],
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
    plugins: [
      'vagrant-berkshelf',
      'vagrant-omnibus',
    ]
  },
)
