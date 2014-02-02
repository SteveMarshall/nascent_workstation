tar_extract node.textmate.source do
  target_dir node.textmate.destination
  creates "#{node.textmate.destination}/TextMate.app"
  user node['current_user']
  group 'staff'
  compress_char 'j'
end

execute "link textmate" do
  command "ln -s #{node.textmate.destination}/TextMate.app/Contents/Resources/mate #{node.textmate.cmd_destination}/mate"
  not_if "test -e #{node.textmate.cmd_destination}/mate"
end

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
