unless Dir.exists?("/usr/local/packer")
  remote_file "#{Chef::Config[:file_cache_path]}/packer.zip" do
    source "https://dl.bintray.com/mitchellh/packer/0.3.1_darwin_amd64.zip?direct"
    owner WS_USER
  end

  execute "unzip Packer" do
    command "unzip #{Chef::Config[:file_cache_path]}/packer.zip -d #{Regexp.escape("/usr/local/packer")}"
    user WS_USER
  end
end
