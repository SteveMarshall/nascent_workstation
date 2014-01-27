# git "#{ENV['HOME']}" do
#   repository "git@github.com:SteveMarshall/homedir.git"
#   reference "master"
#   user node['current_user']
# end

[
  'Default Window Settings',
  'Startup Window Settings',
].each do |setting|
  mac_os_x_userdefaults "Default windows to Pro theme" do
    user node['current_user']
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
    user node['current_user']
  end
end
