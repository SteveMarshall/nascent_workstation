git "#{ENV['HOME']}/Library/Services/open-in-chrome.workflow" do
  repo "git@github.com:SteveMarshall/open-in-chrome.workflow.git"
  action :sync
  user node['current_user']
end

git "#{Chef::Config[:file_cache_path]}/resize-services" do
  repo "git@github.com:SteveMarshall/osx-window-resize-services.git"
  action :sync
end

execute "install_resizers" do
  cwd "#{Chef::Config[:file_cache_path]}/resize-services"
  command %Q{sudo su #{node['current_user']} -l -c "make install"}
end
