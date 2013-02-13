# HACK: pivotal_workstation_defaults doesn't support dict yet
background_settings = "{
  \"\" = {
    default = {
      BackgroundColor = (
          \"0.2549019753932953\",
          \"0.4117647111415863\",
          \"0.6666666865348816\"
      );
      Change = Never;
      ChangePath = \"/Library/Desktop Pictures\";
      ChangeTime = 1800;
      DrawBackgroundColor = 1;
      ImageFilePath = \"/Users/smarshall/Dropbox/Pictures/Wallpapers/Louie Mantia/Blueprint Neue.jpg\";
      NewChangePath = \"/Library/Desktop Pictures\";
      NewImageFilePath = \"/Users/smarshall/Dropbox/Pictures/Wallpapers/Louie Mantia/Blueprint Neue.jpg\";
      NoImage = 0;
      Placement = Crop;
      Random = 0;
    };
  };
}"
execute "Set background" do
  command "defaults write com.apple.desktop Background -dict spaces \'#{background_settings}\'"
  user WS_USER
  notifies :run, "execute[restart Dock]"
end

# TODO: Disable screen saver

pivotal_workstation_defaults "Set minimalist menubar" do
  # Expedia explicitly set this, for some reason
  domain 'com.apple.systemuiserver'
  key 'menuExtras'
  array [
    '/System/Library/CoreServices/Menu Extras/AirPort.menu',
    '/System/Library/CoreServices/Menu Extras/Clock.menu'
  ]
  notifies :run, "execute[restart SystemUIServer]"
end

execute "restart Dock" do
  command "killall Dock"
  action :nothing
  ignore_failure true # SystemUIServer is not running if not logged in
end
execute "restart SystemUIServer" do
  command "killall -HUP SystemUIServer"
  action :nothing
  ignore_failure true # SystemUIServer is not running if not logged in
end
