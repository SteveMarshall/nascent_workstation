[
  'Development',
  'Virtual Machines',
].each do |directory|
  directory "#{ENV['HOME']}/#{directory}" do
    owner WS_USER
    recursive true
  end
end
# TODO: Set icons

execute "Ensure ~/Library is hidden" do
  # EI unhide this?!
  command "chflags hidden #{ENV['HOME']}/Library"
  user WS_USER
end
