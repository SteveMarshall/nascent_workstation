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
