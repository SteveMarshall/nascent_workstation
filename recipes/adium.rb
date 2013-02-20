include_recipe "pivotal_workstation::adium"

directory "#{ENV['HOME']}/Library/Application Support/Adium 2.0" do
  action :delete
  not_if %Q{test -L "#{ENV['HOME']}/Library/Application Support/Adium 2.0"}
end
link "#{ENV['HOME']}/Library/Application Support/Adium 2.0" do
  to "#{ENV['HOME']}/Dropbox/Library/Application Support/Adium 2.0"
end

file "#{ENV['HOME']}/Library/Preferences/com.adiumX.adiumX.plist" do
  action :delete
  not_if %Q{test -L "#{ENV['HOME']}/Library/Preferences/com.adiumX.adiumX.plist"}
end
link "#{ENV['HOME']}/Library/Preferences/com.adiumX.adiumX.plist" do
  to "#{ENV['HOME']}/Dropbox/Library/Preferences/com.adiumX.adiumX.plist"
end
