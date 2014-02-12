default_attributes(
  dashboard: {
    widgets: {
      MiniBatteryStatus: "http://www.emeraldion.it/software/download/494/MiniBatteryStatus-2.6.10.zip"
    }
  },
  sysprefs_users: {
    login_items: [
      "/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app",
      "#{ENV['HOME']}/Applications/Dropbox.app",
      "#{ENV['HOME']}/Applications/Adium.app",
      "#{ENV['HOME']}/Applications/UnPlugged.app",
      "#{ENV['HOME']}/Applications/Stay.app",
      "#{ENV['HOME']}/Library/Application Support/Things Sandbox Helper/Things Helper.app",
    ]
  },
)
run_list(
  "role[development]",
  "recipe[nascent_workstation::sysprefs_dock]",
  "recipe[nascent_workstation::sysprefs_energy]",
)
