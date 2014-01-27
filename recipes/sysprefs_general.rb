# General preferences
aqua_color_variant_blue = 1
aqua_color_variant_graphite = 6

mac_os_x_userdefaults "Set aqua appearance color variant" do
  user node['current_user']
  domain 'NSGlobalDomain'
  key "AppleAquaColorVariant"
  value aqua_color_variant_graphite
  type 'integer'
end

mac_os_x_userdefaults "Set graphite highlight color" do
  user node['current_user']
  domain 'NSGlobalDomain'
  key 'AppleHighlightColor'
  value "0.780400 0.815700 0.858800"
  type 'string'
end
