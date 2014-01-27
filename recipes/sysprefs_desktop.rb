# HACK: mac_os_x_userdefaults doesn't support dict yet
background_image = "~/Dropbox/Pictures/Wallpapers/dizzyup/Dark/Clean.jpg"
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
  user node['current_user']
  notifies :run, "execute[restart Dock]"
end

# TODO: Revert to default screen saver
# mac_os_x_userdefaults "Revert to default screensaver (Flurry)" do
# NB: -currentHost needs to be before `read/write`, which this won't do :(
#   domain '-currentHost com.apple.screensaver'
#   key 'moduleDict'
#   action :delete
# end

# Screen Saver > Start after: Never
plist_dir = ENV['HOME'] + "/Library/Preferences/ByHost"
Dir["#{plist_dir}/com.apple.screensaver.*.plist"].each do |file|
  # %w{modulePath moduleName moduleDict}.each{ |screensaverSetting|
  #   mac_os_x_userdefaults "set screensaver to default" do
  #     user node['current_user']
  #     domain file
  #     key screensaverSetting
  #     action :delete
  #   end
  # }
  execute "Set screensaver to Flurry" do
    command "defaults write #{file} moduleDict -dict moduleName Flurry path '/System/Library/Screen Savers/Flurry.saver' type 0"
    user node['current_user']
    notifies :run, "execute[restart Dock]"
  end
  mac_os_x_userdefaults "set screensaver timeout" do
    user node['current_user']
    domain file
    key 'idleTime'
    value 0
    type 'integer'
  end
end
