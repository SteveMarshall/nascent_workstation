mac_os_x_userdefaults "Enable full keyboard access for all controls" do
  user node['current_user']
  domain "NSGlobalDomain"
  key "AppleKeyboardUIMode"
  value 2
  type 'integer'
end
