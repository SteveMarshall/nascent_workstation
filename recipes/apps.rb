include_recipe "nascent_workstation::finder"
include_recipe "nascent_workstation::safari"
include_recipe "nascent_workstation::terminal"
include_recipe "nascent_workstation::messages"

directory "#{ENV['HOME']}/Applications" do
  owner WS_USER
  recursive true
end

include_recipe "nascent_workstation::adium"
include_recipe "pivotal_workstation::dropbox"
include_recipe "nascent_workstation::textmate"
include_recipe "pivotal_workstation::things"
include_recipe "nascent_workstation::transmit"
include_recipe "nascent_workstation::hex_color_picker"

%w{
  Flint
  Tweetbot
  xScope
}.each do |app|
  execute "Move App Store apps to ~/Applications" do
    command %Q{mv /Applications/#{app}.app ~/Applications/#{app}.app}
    only_if "test -d /Applications/#{app}.app"
  end
end

# Configure work crap
include_recipe "nascent_workstation::sophos"
