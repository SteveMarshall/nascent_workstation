git "#{ENV['HOME']}/Library/Services/open-in-chrome.workflow" do
  repo "git@github.com:SteveMarshall/open-in-chrome.workflow.git"
  action :sync
  user node['current_user']
end

git "#{ENV['HOME']}/Library/Services/resize-services" do
  repo "git@github.com:SteveMarshall/osx-window-resize-services.git"
  action :sync
  user node['current_user']
end

execute "install_resizers" do
  cwd "#{ENV['HOME']}/Library/Services/resize-services"
  command %Q{sudo su #{node['current_user']} -l -c "make install"}
end
