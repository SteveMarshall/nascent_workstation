execute "Ensure Safari's closed" do
  command "killall Safari"
  ignore_failure true
end

pivotal_workstation_defaults "Hide Safari's favorites bar" do
  domain 'com.apple.safari'
  key 'ShowFavoritesBar'
  boolean false
end
%w{
  IncludeDevelopMenu
  WebKitDeveloperExtrasEnabledPreferenceKey
  SendDoNotTrackHTTPHeader
  WebKitWebGLEnabled
}.each do |preference|
  pivotal_workstation_defaults "Enable #{preference}" do
    domain 'com.apple.safari'
    key preference
    boolean true
  end
end

pivotal_workstation_defaults "New windows open with: Empty Page" do
  domain 'com.apple.safari'
  key 'NewWindowBehavior'
  integer 1
end
pivotal_workstation_defaults "New tabs open with: Empty Page" do
  domain 'com.apple.safari'
  key 'NewTabBehavior'
  integer 1
end
pivotal_workstation_defaults "Remove download list items: Upon Successful Download" do
  domain 'com.apple.safari'
  key 'DownloadsClearingPolicy'
  integer 2
end

pivotal_workstation_defaults "Allow tabbing to links" do
  domain 'com.apple.safari'
  key 'WebKitTabToLinksPreferenceKey'
  integer 0
end

pivotal_workstation_defaults "Allow any domains to be added as accounts" do
  domain 'com.apple.safari'
  key 'DomainsToNeverSetUp'
  action :delete
end

pivotal_workstation_defaults "Install extension updates automatically" do
  domain 'com.apple.safari'
  key "InstallExtensionUpdatesAutomatically"
  boolean true
end
directory "#{ENV['HOME']}/Library/Safari/Extensions" do
  owner WS_USER
  recursive true
end

# HACK: Force basic extension metadata to fool Safari into thinking we installed these
cookbook_file "#{ENV['HOME']}/Library/Safari/Extensions/Extensions.plist" do
  source "safari_extensions_skeleton.plist"
  owner WS_USER
end
# TODO: Identify other installed extensions
extensions = {
  # TODO: Detox?
  "Google Reader Background Tabs" => {
    :source => "https://github.com/zakj/Google-Reader-Background-Tabs.safariextension/raw/gh-pages/Google-Reader-Background-Tabs.safariextz",
    :checksum => "322f10418482634a12377d1b1c268d8d52b992a2"
  },
  # TODO: Jargone
  "JSON Formatter" => {
    :source => "https://github.com/downloads/rfletcher/safari-json-formatter/JSON_Formatter-1.1.safariextz",
    :checksum => "aab8dda4486079efa57fe22f7af704a9baf7d2b5"
  },
  "Media Center" => {
    :source => "http://hoyois.github.com/safariextensions/builds/MediaCenter-1.9.safariextz",
    :checksum => "026fb037f5b0e5dfe3eec211d5731674b3642a50"
  },
  "Readability" => {
    :source => "https://www.readability.com/extension/safari",
    :checksum => "73c0c5f5c27354729c511b4cc3cb8d9c9014529b",
    :removed_default_toolbar_items => [
      "com.readability.safari-6K2928F88K readability_save",
      "com.readability.safari-6K2928F88K readability_kindle",
      "com.readability.safari-6K2928F88K readability_read"
    ]
  },
  "SafariKeywordSearch" => {
    :source => "http://safarikeywordsearch.aurlien.net/SafariKeywordSearch.safariextz",
    :checksum => "fd651e4b284b339d38676bf84b58b9b88523a14d"
  },
  "YouTube5" => {
    :source => "http://www.verticalforest.com/youtube5/YouTube5.safariextz",
    :checksum => "f7485d795ad8cb8153ad82a834d465f89ca63f6f"
  },
}

# Install the extensions
extensions.each do |name, download|
  remote_file "#{ENV['HOME']}/Library/Safari/Extensions/#{name}.safariextz" do
    source download[:source]
    checksum download[:checksum]
    owner WS_USER
    mode 00777
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
pivotal_workstation_defaults "Configure installed extensions" do
  domain "#{ENV['HOME']}/Library/Safari/Extensions/Extensions.plist"
  key "Installed Extensions"
  array extensions_plist
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
  "ExtensionSettings-com.hoyois.safari.mediacenter-GY5KR7239Q" => '{
    airplayHostname = "\\"apple-tv.local\\"";
  }',
  "ExtensionSettings-com.readability.safari-6K2928F88K" => '{
    first_run_complete = true;
  }',
  "ExtensionSettings-com.verticalforest.youtube5-B7HHQRRC44" => '{
    enableVimeo = false;
    enableYouTube = true;
  }',
}.each do |property, values|
  execute "Set Safari extension properties" do
    command %Q{defaults write com.apple.safari #{property} '#{values}'}
    user WS_USER
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
# TODO: Safari Keyword Search settings in sqlite3 DB at ~/Library/Safari/LocalStorage/safari-extension_net.aurlien.safarikeywordsearch-5ysse2v8p3_0.localstorage
# CREATE TABLE ItemTable (key TEXT UNIQUE ON CONFLICT REPLACE, value BLOB NOT NULL ON CONFLICT FAIL);
# {
#   :a => "https://www.amazon.co.uk/s/?field-keywords=@@@",
#   :bug => "http://eanjira/browse/@@@",
#   :cpan => "http://search.cpan.org/search?mode=all&query=@@@",
#   :ddg => "http://duckduckgo.com/?q=@@@",
#   :down => "http://downforeveryoneorjustme.com/@@@",
#   :g => "http://www.google.com/search?q=@@@",
#   :imdb => "http://imdb.com/find?s=all&q=@@@",
#   :maps => "http://maps.google.co.uk/maps?oi=map&q=@@@",
#   :wa => "http://www.wolframalpha.com/input/?i=@@@",
#   :w => "http://en.wikipedia.org/wiki/Special:Search/%%%",
#   :y => "http://youtube.com/results?search_query=@@@"
#   # ___keywordExpansionsAreSaved|1
#   # ___defaultUpgraded|1
#   :Default => "ddg"
# }