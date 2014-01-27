unless File.exists?("#{ENV['HOME']}/Applications/Transmit.app")
  remote_file "#{Chef::Config[:file_cache_path]}/transmit.zip" do
    source "http://www.panic.com/transmit/d/Transmit%204.3.2.zip"
    owner node['current_user']
    checksum "122fd9460854574d2a39f8c8f1b86c17e57013a1"
  end

  execute "unzip Transmit" do
    command "unzip #{Chef::Config[:file_cache_path]}/transmit.zip -d #{Regexp.escape("~/Applications")}"
    user node['current_user']
  end
end

directory "#{ENV['HOME']}/Library/Application Support/Transmit" do
  action :delete
  recursive true
  not_if %Q{test -L "#{ENV['HOME']}/Library/Application Support/Transmit"}
end
link "#{ENV['HOME']}/Library/Application Support/Transmit" do
  to "#{ENV['HOME']}/Dropbox/Library/Application Support/Transmit"
end

file "#{ENV['HOME']}/Library/Preferences/com.panic.Transmit.plist" do
  action :delete
  not_if %Q{test -L "#{ENV['HOME']}/Library/Preferences/com.panic.Transmit.plist"}
end
link "#{ENV['HOME']}/Library/Preferences/com.panic.Transmit.plist" do
  to "#{ENV['HOME']}/Dropbox/Library/Preferences/com.panic.Transmit.plist"
end
