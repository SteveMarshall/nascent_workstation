execute "restart Dock" do
  command "killall Dock"
  action :nothing
  ignore_failure true
end
execute "restart Finder" do
  command "killall Finder"
  action :nothing
  ignore_failure true
end
execute "restart SystemUIServer" do
  command "killall -HUP SystemUIServer"
  action :nothing
  ignore_failure true
end
