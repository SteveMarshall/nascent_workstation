# TODO: Create admin user and de-auth current user
ruby_block "give_#{WS_USER}_sudo" do
  block do
    file = Chef::Util::FileEdit.new("/etc/sudoers")
    file.insert_line_if_no_match(/#{WS_USER}/, "#{WS_USER} ALL=(ALL) ALL")
    file.write_file
  end
end

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
  "#{ENV['HOME']}/Applications/EAN Dropbox.app",
  "#{ENV['HOME']}/Applications/Adium.app",
  "#{ENV['HOME']}/Applications/UnPlugged.app",
  "#{ENV['HOME']}/Applications/Stay.app",
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
