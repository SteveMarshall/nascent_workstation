tar_extract node['hex_color_picker']['source'] do
  target_dir node['hex_color_picker']['destination']
  creates "#{node['hex_color_picker']['destination']}/HexColorPicker.colorPicker"
  user ENV['SUDO_USER']
  group 'staff'
  tar_flags [
    "--exclude '__MACOSX'",
    "--strip-components 1",
    "'*/*.colorPicker'"
  ]
end
