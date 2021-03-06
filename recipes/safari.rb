execute "Ensure Safari's closed" do
  command "killall Safari"
  ignore_failure true
end

mac_os_x_userdefaults "Hide Safari's favorites bar" do
  user ENV['SUDO_USER']
  domain 'com.apple.safari'
  key 'ShowFavoritesBar'
  value 'FALSE'
  type 'bool'
end
%w{
  IncludeDevelopMenu
  WebKitDeveloperExtrasEnabledPreferenceKey
  SendDoNotTrackHTTPHeader
  WebKitWebGLEnabled
}.each do |preference|
  mac_os_x_userdefaults "Enable #{preference}" do
    user ENV['SUDO_USER']
    domain 'com.apple.safari'
    key preference
    value 'TRUE'
    type 'bool'
  end
end

mac_os_x_userdefaults "New windows open with: Empty Page" do
  user ENV['SUDO_USER']
  domain 'com.apple.safari'
  key 'NewWindowBehavior'
  value 1
  type 'integer'
end
mac_os_x_userdefaults "New tabs open with: Empty Page" do
  user ENV['SUDO_USER']
  domain 'com.apple.safari'
  key 'NewTabBehavior'
  value 1
  type 'integer'
end
mac_os_x_userdefaults "Remove download list items: Upon Successful Download" do
  user ENV['SUDO_USER']
  domain 'com.apple.safari'
  key 'DownloadsClearingPolicy'
  value 2
  type 'integer'
end

mac_os_x_userdefaults "Allow tabbing to links" do
  user ENV['SUDO_USER']
  domain 'com.apple.safari'
  key 'WebKitTabToLinksPreferenceKey'
  value 0
  type 'integer'
end

# mac_os_x_userdefaults "Allow any domains to be added as accounts" do
#   domain 'com.apple.safari'
#   key 'DomainsToNeverSetUp'
#   action :delete
# end

mac_os_x_userdefaults "Install extension updates automatically" do
  user ENV['SUDO_USER']
  domain 'com.apple.safari'
  key "InstallExtensionUpdatesAutomatically"
  value 'TRUE'
  type 'bool'
end
directory "#{ENV['HOME']}/Library/Safari/Extensions" do
  owner ENV['SUDO_USER']
  recursive true
  action [:delete, :create]
end

# HACK: Force basic extension metadata to fool Safari into thinking we installed these
cookbook_file "#{ENV['HOME']}/Library/Safari/Extensions/Extensions.plist" do
  source "safari_extensions_skeleton.plist"
  owner ENV['SUDO_USER']
end
extensions = {
  "JSON Formatter" => {
    :source => "http://cloud.github.com/downloads/rfletcher/safari-json-formatter/JSON_Formatter-1.1.safariextz",
  },
  "Readability" => {
    :source => "https://www.readability.com/extension/safari",
    :removed_default_toolbar_items => [
      "com.readability.safari-6K2928F88K readability_save",
      "com.readability.safari-6K2928F88K readability_kindle",
      "com.readability.safari-6K2928F88K readability_read"
    ]
  },
}

# Install the extensions
extensions.each do |name, download|
  if download[:source] =~ /\.zip$/
    remote_file "#{Chef::Config[:file_cache_path]}/#{name}.zip" do
      source download[:source]
      owner ENV['SUDO_USER']
    end

    execute "unzip #{name}" do
      command "unzip -o #{Chef::Config[:file_cache_path]}/#{name}.zip -d #{Chef::Config[:file_cache_path]}"
    end

    execute "Move #{name} to extensions" do
      command %Q{cp "#{Chef::Config[:file_cache_path]}/#{download[:ext_path]}" #{ENV['HOME']}/Library/Safari/Extensions/}
      user ENV['SUDO_USER']
    end
  else
    remote_file "#{ENV['HOME']}/Library/Safari/Extensions/#{name}.safariextz" do
      source download[:source]
      owner ENV['SUDO_USER']
      mode 00777
      # HACK: Set header to avoid https://tickets.opscode.com/browse/CHEF-5010
      headers({ "Host" => URI.parse(download[:source]).host })
    end
  end
end

# Register the extensions
extensions_plist = extensions.map { |name, download|
  if download[:removed_default_toolbar_items]
    removed_default_toolbar_items = download[:removed_default_toolbar_items].map{ |item|
      "<string>#{item}</string>"
    }.join("")
  end
  %Q{<dict>
    <key>Added Non-Default Toolbar Items</key>
    <array/>
    <key>Archive File Name</key>
    <string>#{name}.safariextz</string>
    <key>Bundle Directory Name</key>
    <string>#{name}.safariextension</string>
    <key>Enabled</key>
    <true/>
    <key>Hidden Bars</key>
    <array/>
    <key>Removed Default Toolbar Items</key>
    <array>#{removed_default_toolbar_items}</array>
  </dict>}
}
mac_os_x_userdefaults "Configure installed extensions" do
  user ENV['SUDO_USER']
  domain "#{ENV['HOME']}/Library/Safari/Extensions/Extensions.plist"
  key "Installed Extensions"
  type 'array'
  value extensions_plist
end

# TODO: Toolbar items
# "NSToolbar Configuration BrowserToolbarIdentifier" =     {
#         "TB Default Item Identifiers" =         (
#             BackForwardToolbarIdentifier,
#             "com.readability.safari-6K2928F88K readability_read",
#             "com.readability.safari-6K2928F88K readability_save",
#             "com.readability.safari-6K2928F88K readability_kindle",
#             CloudTabsToolbarIdentifier,
#             ShareToolbarIdentifier,
#             InputFieldsToolbarIdentifier
#         );
#         "TB Display Mode" = 2;
#         "TB Icon Size Mode" = 1;
#         "TB Is Shown" = 1;
#         "TB Item Identifiers" =         (
#             BackForwardToolbarIdentifier,
#             CloudTabsToolbarIdentifier,
#             InputFieldsToolbarIdentifier
#         );
#         "TB Size Mode" = 1;
#     };


{
  "ExtensionSettings-com.readability.safari-6K2928F88K" => '{
    first_run_complete = true;
  }',
}.each do |property, values|
  execute "Set Safari extension properties" do
    command %Q{defaults write com.apple.safari #{property} '#{values}'}
    user ENV['SUDO_USER']
  end
end

[
  "/Library/Internet\ Plug-Ins/Flash Player.plugin",
  "/Library/PreferencePanes/Flash Player.prefPane",
  "#{ENV['HOME']}/Library/Preferences/Macromedia/Flash Player",
  "#{ENV['HOME']}/Library/Caches/Adobe/Flash Player",
].each { |flashdir|
  directory flashdir do
    recursive true
    action :delete
  end
}
file "/Library/Internet\ Plug-Ins/flashplayer.xpt" do
  action :delete
end
