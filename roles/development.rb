name "development"
description "Things I need for development"

run_list(
  "role[base]",
)

default_attributes(
  apps: {
    Adium: {
      source: 'http://sourceforge.net/projects/adium/files/Adium_1.5.4.dmg/download',
      type: :dmg,
      volumes_dir: 'Adium 1.5.4',
      symlinks: {
        "#{ENV['HOME']}/Library/Application Support/Adium 2.0" => "#{ENV['HOME']}/Dropbox/Library/Application Support/Adium 2.0",
        "#{ENV['HOME']}/Library/Preferences/com.adiumX.adiumX.plist" => "#{ENV['HOME']}/Dropbox/Library/Preferences/com.adiumX.adiumX.plist",
      },
    },
    Things: {
      source: 'http://culturedcode.com/things/download/',
    },
#    Transmit: {
#      source: "http://www.panic.com/transmit/d/Transmit%204.4.5.zip",
#      symlinks: {
#        "#{ENV['HOME']}/Library/Application Support/Transmit" => "#{ENV['HOME']}/Dropbox/Library/Application Support/Transmit",
#        "#{ENV['HOME']}/Library/Preferences/com.panic.Transmit.plist" => "#{ENV['HOME']}/Dropbox/Library/Preferences/com.panic.Transmit.plist",
#      },
#    },
  },
  homebrew: {
    taps: ['homebrew/binary'],
    packages: {
      'packer' => nil,
    }
  }
)
