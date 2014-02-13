node.home.services.each do |source, target|
  git target do
    repo source
    action :sync
    user node['current_user']
  end
end

execute "install_resizers" do
  cwd "#{ENV['HOME']}/Library/Services/resize-services"
  command %Q{sudo su #{node['current_user']} -l -c "make install"}
end
