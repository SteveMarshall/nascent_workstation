# TODO: Create admin user and de-auth current user?

# Set profile image
# TODO: Extract profile image from iCloud contacts?
cookbook_file "#{Chef::Config[:file_cache_path]}/user_image.jpeg" do
  source "user_image.jpeg"
  owner WS_USER
end
template "#{Chef::Config[:file_cache_path]}/jpegphoto.dsimport" do
  source "user_image.dsimport.erb"
  owner WS_USER
end
execute("dscl . delete /Users/#{WS_USER} JPEGPhoto")
execute("dsimport #{Chef::Config[:file_cache_path]}/jpegphoto.dsimport /Local/Default M")

login_items = [
  "/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app",
  "#{ENV['HOME']}/Applications/Dropbox.app",
  "#{ENV['HOME']}/Library/Application Support/Things Sandbox Helper/Things Helper.app",
].map { |app_path| 
  %Q{make login item at end with properties \{path:"#{app_path}"\}}
}.join("\n")
ruby_block "Reset login items" do
  block do
    system(
    %Q{osascript -e '
      tell application "System Events"
        delete login items
        #{login_items}
      end tell
    '}
  )
  end
end
