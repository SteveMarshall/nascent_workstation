unless File.exists?("#{ENV['HOME']}/Applications/Transmit.app")
  remote_file "#{Chef::Config[:file_cache_path]}/transmit.zip" do
    source "http://www.panic.com/transmit/d/Transmit%204.3.2.zip"
    owner WS_USER
    checksum "122fd9460854574d2a39f8c8f1b86c17e57013a1"
  end

  execute "unzip Transmit" do
    command "unzip #{Chef::Config[:file_cache_path]}/transmit.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "Copy Transmit to ~/Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/transmit.app #{Regexp.escape("~/Applications/1Password.app")}"
    user WS_USER
    group "admin"
  end
end
