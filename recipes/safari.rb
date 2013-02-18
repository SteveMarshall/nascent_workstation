# TODO: Ensure Safari's closed

directory "#{ENV['HOME']}/Library/Safari/Extensions" do
  owner WS_USER
  recursive true
end

# HACK: Force basic extension metadata to fool Safari into thinking we installed these
cookbook_file "#{ENV['HOME']}/Library/Safari/Extensions/Extensions.plist" do
  source "safari_extensions_skeleton.plist"
  owner WS_USER
end
extensions = {
  # TODO: Inman's Detox?
  "YouTube5" => {
    :source => "http://www.verticalforest.com/youtube5/YouTube5.safariextz",
    :checksum => "f7485d795ad8cb8153ad82a834d465f89ca63f6f"
  },
  "Google Reader Background Tabs" => {
    :source => "https://github.com/zakj/Google-Reader-Background-Tabs.safariextension/raw/gh-pages/Google-Reader-Background-Tabs.safariextz",
    :checksum => "322f10418482634a12377d1b1c268d8d52b992a2"
  },
  "JSON Formatter" => {
    :source => "https://github.com/downloads/rfletcher/safari-json-formatter/JSON_Formatter-1.1.safariextz",
    :checksum => "aab8dda4486079efa57fe22f7af704a9baf7d2b5"
  },
  "SafariKeywordSearch" => {
    :source => "http://safarikeywordsearch.aurlien.net/SafariKeywordSearch.safariextz",
    :checksum => "fd651e4b284b339d38676bf84b58b9b88523a14d"
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
  "Media Center" => {
    :source => "http://hoyois.github.com/safariextensions/builds/MediaCenter-1.9.safariextz",
    :checksum => "026fb037f5b0e5dfe3eec211d5731674b3642a50"
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
pivotal_workstation_defaults "" do
  domain "#{ENV['HOME']}/Library/Safari/Extensions/Extensions.plist"
  key "Installed Extensions"
  array extensions_plist
end