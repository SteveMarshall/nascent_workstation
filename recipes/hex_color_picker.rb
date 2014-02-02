unless File.exists?("#{node.hex_color_picker.destination}/HexColorPicker.colorPicker")
  remote_file "#{Chef::Config[:file_cache_path]}/HexColorPicker.zip" do
    source "http://wafflesoftware.net/hexpicker/download/"
    owner node['current_user']
  end

  execute "Extract HexColorPicker.colorPicker" do
    cwd node.hex_color_picker.destination
    command %{tar -zx --exclude '__MACOSX' --strip-components 1 -f '#{Chef::Config[:file_cache_path]}/HexColorPicker.zip' '*/*.colorPicker'}
    creates "#{node.hex_color_picker.destination}/HexColorPicker.colorPicker"
  end
end
