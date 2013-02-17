# TODO: User profile image
# TODO: Create admin user and de-auth current user?

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
