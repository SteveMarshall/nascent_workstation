pivotal_workstation_defaults "Enable dock magnification" do
  domain 'com.apple.Dock'
  key 'magnification'
  integer 1
  notifies :run, "execute[restart Dock]"
end
pivotal_workstation_defaults "Enable dock autohide" do
  domain 'com.apple.Dock'
  key 'autohide'
  integer 1
  notifies :run, "execute[restart Dock]"
end
pivotal_workstation_defaults "Set base dock size" do
  domain 'com.apple.Dock'
  key 'tilesize'
  integer 50
  notifies :run, "execute[restart Dock]"
end
pivotal_workstation_defaults "Set magnified dock size" do
  domain 'com.apple.Dock'
  key 'largesize'
  integer 65
  notifies :run, "execute[restart Dock]"
end

# TODO: Persistent apps/folders
# TODO: Work out why clearing the dock doesn’t work
# pivotal_workstation_defaults "Clear the dock" do
#   domain 'com.apple.dock'
#   key 'persistent-apps'
#   action :delete
#   notifies :run, "execute[restart Dock]"
# end
# 
# [
#   "/Applications/Safari.app",
#   "/Applications/Mail.app",
#   "/Applications/Calendar.app",
#   "#{ENV['HOME']}/Applications/Things.app",
#   "/Applications/Notes.app",
#   "/Applications/Messages.app",
#   "#{ENV['HOME']}/Applications/Adium.app",
#   "#{ENV['HOME']}/Applications/Flint.app",
#   "#{ENV['HOME']}/Applications/Twitter.app",
#   "#{ENV['HOME']}/Applications/TextMate.app",
#   "/Applications/Utilities/Terminal.app",
# ].each do |app_path|
#   nascent_workstation_dock_item "Add #{app_path} to dock" do
#     path app_path
#     notifies :run, "execute[restart Dock]"
#   end
# end
