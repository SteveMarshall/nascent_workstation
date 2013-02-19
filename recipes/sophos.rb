# TODO: Only do this if Sophos is already installed
pivotal_workstation_defaults "Hide Sophos's menubar icon" do
  domain 'com.sophos.ui'
  key 'displayMenuIcon'
  integer 0
end
