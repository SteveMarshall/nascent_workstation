# git "#{ENV['HOME']}" do
#   repository "git@github.com:SteveMarshall/homedir.git"
#   reference "master"
#   user WS_USER
# end

[
  'Default Window Settings',
  'Startup Window Settings',
].each do |setting|
  pivotal_workstation_defaults "Default windows to Pro theme" do
    domain 'com.apple.terminal'
    key setting
    string "Pro"
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
    user WS_USER
  end
end
