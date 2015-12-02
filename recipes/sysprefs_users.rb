# Set profile image
# TODO: Extract profile image from iCloud contacts?
cookbook_file "#{Chef::Config[:file_cache_path]}/user_image.jpeg" do
  source "user_image.jpeg"
  owner node['current_user']
end
template "#{Chef::Config[:file_cache_path]}/jpegphoto.dsimport" do
  source "user_image.dsimport.erb"
  owner node['current_user']
end
execute("dscl . delete /Users/#{node['current_user']} JPEGPhoto")
execute("dsimport #{Chef::Config[:file_cache_path]}/jpegphoto.dsimport /Local/Default M")

login_items = node['sysprefs_users']['login_items'].map { |app_path|
  %Q{make login item at end with properties \{path:\\"#{app_path}\\"\}}
}.join("\n")
execute "Reset login items" do
  command %Q{sudo su #{ENV['SUDO_USER']} -l -c "osascript -e '
    tell application \\"System Events\\"
      delete login items
      #{login_items}
    end tell
  '"}
end
