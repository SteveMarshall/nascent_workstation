unless File.exists?("#{ENV['HOME']}/Library/ColorPickers/HexColorPicker.colorPicker")
  remote_file "#{Chef::Config[:file_cache_path]}/HexColorPicker.zip" do
    source "http://wafflesoftware.net/hexpicker/download/"
    owner WS_USER
  end

  execute "unzip HexColorPicker" do
    command "unzip -o #{Chef::Config[:file_cache_path]}/HexColorPicker.zip -d #{Chef::Config[:file_cache_path]}"
  end
  
  execute "copy HexColorPicker to Library" do
    command %Q{cp -r "#{Chef::Config[:file_cache_path]}/Hex Color Picker/HexColorPicker.colorPicker" #{Regexp.escape("~/Library/ColorPickers/HexColorPicker.colorPicker")}}
    user WS_USER
  end
end
