# HACK: pivotal_workstation_defaults doesn't support dict yet
background_settings = "{
  \"\" = {
    default = {
      ImageFilePath = \"~/Dropbox/Pictures/Wallpapers/Louie Mantia/Empire/Empire Kamino Widescreen.jpg\";
    };
  };
}"
execute "Set background" do
  command "defaults write com.apple.desktop Background -dict spaces \'#{background_settings}\'"
  user WS_USER
  notifies :run, "execute[restart Dock]"
end

# This doesn't really fit anywhere, so here will do.
pivotal_workstation_defaults "Set minimalist menubar" do
  domain 'com.apple.systemuiserver'
  key 'menuExtras'
  array [
    '/System/Library/CoreServices/Menu Extras/AirPort.menu',
    '/System/Library/CoreServices/Menu Extras/Clock.menu'
  ]
  notifies :run, "execute[restart SystemUIServer]"
end

# TODO: Revert to default screen saver
# pivotal_workstation_defaults "Revert to default screensaver (Flurry)" do
# NB: -currentHost needs to be before `read/write`, which this won't do :(
#   domain '-currentHost com.apple.screensaver'
#   key 'moduleDict'
#   action :delete
# end

# Screen Saver > Start after: Never
plist_dir = ENV['HOME'] + "/Library/Preferences/ByHost"
Dir["#{plist_dir}/com.apple.screensaver.*.plist"].each do |file|
  pivotal_workstation_defaults "set screensaver timeout" do
    domain file
    key 'idleTime'
    integer 0
  end
end
