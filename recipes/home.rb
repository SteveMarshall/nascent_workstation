[
  'Development',
  'Virtual Machines',
].each do |directory|
  directory "#{ENV['HOME']}/#{directory}" do
    owner node['current_user']
    recursive true
  end
end
# TODO: Set icons

execute "Ensure ~/Library is hidden" do
  # EI unhide this?!
  command "chflags hidden #{ENV['HOME']}/Library"
  user node['current_user']
end
