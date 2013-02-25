include_recipe "pivotal_workstation::textmate"

directory "#{ENV['HOME']}/Library/Application Support/TextMate" do
  action :delete
  recursive true
  not_if %Q{test -L "#{ENV['HOME']}/Library/Application Support/TextMate"}
end
link "#{ENV['HOME']}/Library/Application Support/TextMate" do
  to "#{ENV['HOME']}/Dropbox/Library/Application Support/TextMate"
end

file "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist" do
  action :delete
  not_if %Q{test -L "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist"}
end
link "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist" do
  to "#{ENV['HOME']}/Dropbox/Library/Preferences/com.macromates.textmate.plist"
end
