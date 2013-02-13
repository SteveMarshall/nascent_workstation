# General preferences
include_recipe "pivotal_workstation::osx_aqua_color_preferences"
pivotal_workstation_defaults "Set graphite highlight color" do
  domain 'NSGlobalDomain'
  key 'AppleHighlightColor'
  string "0.780400 0.815700 0.858800"
end

pivotal_workstation_defaults "Set scrollbar visibility to Apple's default" do
  # Expedia explicitly set this, for some reason
  domain 'NSGlobalDomain'
  key 'AppleShowScrollBars'
  action :delete
end
