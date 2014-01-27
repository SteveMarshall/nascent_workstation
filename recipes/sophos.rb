# TODO: Only do this if Sophos is already installed
mac_os_x_userdefaults "Hide Sophos's menubar icon" do
  user node['current_user']
  domain 'com.sophos.ui'
  key 'displayMenuIcon'
  value 0
  type 'integer'
end
