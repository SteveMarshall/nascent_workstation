node['home']['directories'].each do |directory|
  directory "#{ENV['HOME']}/#{directory}" do
    owner ENV['SUDO_USER']
    recursive true
  end
end
# TODO: Set icons

directory "#{ENV['HOME']}/Downloads/About Downloads.lpdf" do
  recursive true
  action :delete
end
