zip_app_package "Transmit" do
  source node.transmit.source
  destination node.transmit.destination
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
