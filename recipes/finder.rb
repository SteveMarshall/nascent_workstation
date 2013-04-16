# TODO: Manage sidebar items

%w{
  ShowExternalHardDrivesOnDesktop
  ShowHardDrivesOnDesktop
  ShowRemovableMediaOnDesktop
}.each do |property|
  pivotal_workstation_defaults "Disable #{property}" do
    domain 'com.apple.finder'
    key property
    boolean false
  end
end

pivotal_workstation_defaults "Default to current folder when searching" do
  domain 'com.apple.finder'
  key 'FXDefaultSearchScope'
  string 'SCcf'
end

%w{
  DesktopViewSettings
  FK_StandardViewSettings
  FXDesktopVolumePositions
  MeetingRoomViewSetting
  NetworkViewSettings
  PackageViewSettings
  SearchViewSettings
  StandardViewSettings
  TrashViewSettings
}.each do |property|
  pivotal_workstation_defaults "Remove view customisation: #{property}" do
    domain 'com.apple.finder'
    key property
    action :delete
    notifies :run, "execute[restart Finder]"
  end
end

icon_view_settings = {
  :arrangeBy       => {:type => :string,  :value => "name"},
  :iconSize        => {:type => :real,    :value => 48},
  :gridSpacing     => {:type => :real,    :value => 58},
  :labelOnBottom   => {:type => :boolean, :value => false},
  :showIconPreview => {:type => :boolean, :value => true},
  :showItemInfo    => {:type => :boolean, :value => true},

  # HACK: If we don't include these, Finder ignores _everything_.
  :backgroundColorBlue  => {:type => :real,    :value => 1},
  :backgroundColorGreen => {:type => :real,    :value => 1},
  :backgroundColorRed   => {:type => :real,    :value => 1},
  :textSize             => {:type => :real,    :value => 12},
}.map { |property, data|
  if :boolean == data[:type]
    "<key>#{property}</key><#{data[:value]}/>"
  else
    "<key>#{property}</key><#{data[:type]}>#{data[:value]}</#{data[:type]}>"
  end
}.join('')
icon_view_settings = "<dict>#{icon_view_settings}</dict>"
%w{
  StandardViewSettings
  DesktopViewSettings
}.each do |property|
  execute "Set Finder window customisations" do
    command "defaults write com.apple.finder #{property} -dict IconViewSettings \'#{icon_view_settings}\'"
    user WS_USER
    notifies :run, "execute[restart Finder]"
  end
end

unless File.exists?("#{ENV['HOME']}/Library/QuickLook/QLMarkdown.qlgenerator")
  remote_file "#{Chef::Config[:file_cache_path]}/QLMarkdown.zip" do
    source "https://github.com/downloads/toland/qlmarkdown/QLMarkdown-1.3.zip"
    owner WS_USER
    checksum "39b0175bf49bc59ad04aa5520b911d2e187e3daa"
  end

  directory "#{ENV['HOME']}/Library/QuickLook" do
    owner WS_USER
  end

  execute "unzip QLMarkdown" do
    command "unzip #{Chef::Config[:file_cache_path]}/QLMarkdown.zip -d #{Chef::Config[:file_cache_path]}"
    user WS_USER
    not_if %Q{test -d "#{Chef::Config[:file_cache_path]}/QLMarkdown"}
  end
  execute "Relocate QLMarkdown" do
    command "cp -r #{Chef::Config[:file_cache_path]}/QLMarkdown/QLMarkdown.qlgenerator #{Regexp.escape("~/Library/QuickLook")}"
    user WS_USER
  end
end
