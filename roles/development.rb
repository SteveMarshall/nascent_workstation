name "development"
description "Things I need for development"

run_list(
  "role[base]",
  "recipe[chruby]",
)

default_attributes(
  apps: {
    Adium: {
      source: 'http://sourceforge.net/projects/adium/files/Adium_1.5.10.dmg/download',
      type: :dmg,
      volumes_dir: 'Adium 1.5.10',
      symlinks: {
        "#{ENV['HOME']}/Library/Application Support/Adium 2.0" => "#{ENV['HOME']}/Dropbox/Library/Application Support/Adium 2.0",
        "#{ENV['HOME']}/Library/Preferences/com.adiumX.adiumX.plist" => "#{ENV['HOME']}/Dropbox/Library/Preferences/com.adiumX.adiumX.plist",
      },
    },
    Things: {
      source: 'http://culturedcode.com/things/download/',
    },
  },
  homebrew: {
    casks: [
      'dockertoolbox',
    ],
    formulas: [
      'chruby',
      'ruby-install',
    ],
  },
  chruby: {
    rubies: {
      ruby: [
        ''
      ],
    }
  }
)
