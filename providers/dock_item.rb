action :add do
  dock_item = %Q{
    <dict>
        <key>tile-data</key>
        <dict>
            <key>file-data</key>
            <dict>
                <key>_CFURLString</key>
                <string>#{new_resource.path}/</string>
                <key>_CFURLStringType</key>
                <integer>0</integer>
            </dict>
        </dict>
    </dict>
  }
  execute "#{new_resource.description}"  do
    command "defaults write com.apple.dock 'persistent-apps' -array-add '#{dock_item}'"
    user WS_USER
  end
end
