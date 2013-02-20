directory "#{ENV['HOME']}/Library/Messages" do
  action :delete
  not_if %Q{test -L "#{ENV['HOME']}/Library/Messages"}
end
link "#{ENV['HOME']}/Library/Messages" do
  to "#{ENV['HOME']}/Dropbox/Library/Messages"
end
