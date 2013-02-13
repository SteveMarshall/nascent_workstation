execute "restart Dock" do
  command "killall Dock"
  action :nothing
  ignore_failure true # SystemUIServer is not running if not logged in
end
execute "restart SystemUIServer" do
  command "killall -HUP SystemUIServer"
  action :nothing
  ignore_failure true # SystemUIServer is not running if not logged in
end
