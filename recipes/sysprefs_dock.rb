mac_os_x_userdefaults "Enable dock magnification" do
  user node['current_user']
  domain 'com.apple.Dock'
  key 'magnification'
  value 1
  type 'integer'
  notifies :run, "execute[restart Dock]"
end
mac_os_x_userdefaults "Enable dock autohide" do
  user node['current_user']
  domain 'com.apple.Dock'
  key 'autohide'
  value 'true'
  type 'boolean'
  notifies :run, "execute[restart Dock]"
end
mac_os_x_userdefaults "Set base dock size" do
  user node['current_user']
  domain 'com.apple.Dock'
  key 'tilesize'
  value 50
  type 'integer'
  notifies :run, "execute[restart Dock]"
end
mac_os_x_userdefaults "Set magnified dock size" do
  user node['current_user']
  domain 'com.apple.Dock'
  key 'largesize'
  value 65
  type 'integer'
  notifies :run, "execute[restart Dock]"
end

persistent_apps = [
  "/Applications/Safari.app",
  "/Applications/Mail.app",
  "/Applications/Calendar.app",
  "#{ENV['HOME']}/Applications/Things.app",
  "/Applications/Messages.app",
  "#{ENV['HOME']}/Applications/HipChat.app",
  "#{ENV['HOME']}/Applications/Adium.app",
  "#{ENV['HOME']}/Applications/Tweetbot.app",
  "#{ENV['HOME']}/Applications/TextMate.app",
  "/Applications/Utilities/Terminal.app",
].map { |app_path|
  "<dict>
    <key>tile-data</key>
    <dict>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>#{app_path}/</string>
        <key>_CFURLStringType</key>
        <integer>0</integer>
      </dict>
    </dict>
  </dict>"
}
mac_os_x_userdefaults "Set persistent apps" do
  user node['current_user']
  domain 'com.apple.dock'
  key 'persistent-apps'
  value persistent_apps
  type 'array'
  notifies :run, "execute[restart Dock]"
end

dock_display_as = {
  :stack => 0,
  :folder => 1,
}
dock_sort_by = {
  :name => 0,
  :date_added => 2,
  :date_modified => 3,
  :date_created => 4,
  :kind => 5,
}
dock_view_contents_as = {
  :automatic => 0,
  :fan => 1,
  :grid => 2,
  :list => 3
}
persistent_others = {
  "#{ENV['HOME']}/Downloads" => {
    :displayas => dock_display_as[:stack],
    :arrangement => dock_sort_by[:date_added],
    :showas => dock_view_contents_as[:automatic],
  },
  "#{ENV['HOME']}/Dropbox/Documents/Home" => {
    :displayas => dock_display_as[:folder],
    :arrangement => dock_sort_by[:name],
    :showas => dock_view_contents_as[:automatic],
  },
  "#{ENV['HOME']}/Dropbox/Documents/Work" => {
    :displayas => dock_display_as[:folder],
    :arrangement => dock_sort_by[:name],
    :showas => dock_view_contents_as[:automatic],
  },
  "#{ENV['HOME']}/Work Dropbox" => {
    :displayas => dock_display_as[:folder],
    :arrangement => dock_sort_by[:name],
    :showas => dock_view_contents_as[:automatic],
  },
}.map { |item_path, settings|
  "<dict>
    <key>tile-type</key>
    <string>directory-tile</string>
    <key>tile-data</key>
    <dict>
      <key>arrangement</key>
      <integer>#{settings[:arrangement]}</integer>
      <key>displayas</key>
      <integer>#{settings[:displayas]}</integer>
      <key>showas</key>
      <integer>#{settings[:showas]}</integer>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>#{item_path}/</string>
        <key>_CFURLStringType</key>
        <integer>0</integer>
      </dict>
    </dict>
  </dict>"
}
mac_os_x_userdefaults "Set persistent others" do
  user node['current_user']
  domain 'com.apple.dock'
  key 'persistent-others'
  type 'array'
  value persistent_others
  notifies :run, "execute[restart Dock]"
end

directory "#{ENV['HOME']}/Downloads/About Downloads.lpdf" do
  recursive true
  action :delete
end
