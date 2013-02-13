pivotal_workstation_defaults "Ask for password when screen is locked" do
  domain 'com.apple.screensaver'
  key 'askForPassword'
  integer 1
end

pivotal_workstation_defaults "Require password 5 seconds after sleep or screen saver begins" do
  domain 'com.apple.screensaver'
  key 'askForPasswordDelay'
  float 5
end

# TODO: Allow apps from MAS & ID'd devs
# TODO: FileVault
# TODO: Firewall
# TODO: Privacy
# TODO: Advanced