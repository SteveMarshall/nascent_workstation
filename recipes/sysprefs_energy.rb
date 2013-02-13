execute "Set battery power settings" do
  command "pmset -b displaysleep 15 sleep 30"
end
execute "Set adapter power settings" do
  command "pmset -c displaysleep 30 sleep 0"
end
