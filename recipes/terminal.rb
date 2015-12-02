[
  'Default Window Settings',
  'Startup Window Settings',
].each do |setting|
  mac_os_x_userdefaults "Default windows to Pro theme" do
    user ENV['SUDO_USER']
    domain 'com.apple.terminal'
    key setting
    value "Pro"
    type 'string'
  end
end

{
  :Bell => false,
  :Linewrap => true,
  :ShowDimensionsInTitle => false,
  :UseBrightBold => false,
  :VisualBell => true,
  :shellExitAction => 1,
}.each do |key, value|
  execute "Configure Terminal Pro theme" do
    command "defaults write com.apple.terminal Background -dict-add #{key} #{value}"
    user ENV['SUDO_USER']
  end
end
