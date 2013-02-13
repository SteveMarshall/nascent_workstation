# HACK: pivotal_workstation_defaults doesn't support dict yet
background_settings = "{
  \"\" = {
    default = {
      ImageFilePath = \"~/Dropbox/Pictures/Wallpapers/Louie Mantia/Blueprint Neue.jpg\";
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
