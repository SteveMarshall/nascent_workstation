persistent_apps = node.dock.persistent_apps.map { |app_path|
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

persistent_others = node.dock.persistent_others.map { |item_path, settings|
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
