pivotal_workstation_defaults "Hide Sophos's menubar icon" do
  # Expedia explicitly set this, for some reason
  domain 'com.sophos.ui'
  key 'displayMenuIcon'
  integer 0
end
