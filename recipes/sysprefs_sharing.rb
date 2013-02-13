# TODO: Enable screen sharing, file sharing

execute "Enable 'Remote Login' (aka ssh)" do
  command "systemsetup -setremotelogin on"
end
# TODO: Configure SSHd?