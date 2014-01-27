mac_os_x_userdefaults "Ask for password when screen is locked" do
  user node['current_user']
  domain 'com.apple.screensaver'
  key 'askForPassword'
  value 1
  type 'integer'
end

mac_os_x_userdefaults "Require password 5 seconds after sleep or screen saver begins" do
  user node['current_user']
  domain 'com.apple.screensaver'
  key 'askForPasswordDelay'
  value 5
  type 'float'
end

# TODO: Allow apps from MAS & ID'd devs
# TODO: FileVault
# TODO: Firewall
# TODO: Privacy
# TODO: Advanced