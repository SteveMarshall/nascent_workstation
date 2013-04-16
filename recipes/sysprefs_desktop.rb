# HACK: pivotal_workstation_defaults doesn't support dict yet
background_image = "~/Dropbox/Pictures/Wallpapers/Louie Mantia/SHIELD.jpg"
background_settings = "{
  \"\" = {
    69516202 = {
      ImageFilePath = \"#{background_image}\";
    };
    69730624 = {
      ImageFilePath = \"#{background_image}\";
    };
    default = {
      ImageFilePath = \"#{background_image}\";
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
  %w{modulePath moduleName moduleDict}.each{ |screensaverSetting|
    pivotal_workstation_defaults "set screensaver to default" do
      domain file
      key screensaverSetting
      action :delete
    end
  }
  execute "Set screensaver to Flurry" do
    command "defaults write #{file} moduleDict -dict moduleName Flurry path '/System/Library/Screen Savers/Flurry.saver' type 0"
    user WS_USER
    notifies :run, "execute[restart Dock]"
  end
  pivotal_workstation_defaults "set screensaver timeout" do
    domain file
    key 'idleTime'
    integer 0
  end
end
