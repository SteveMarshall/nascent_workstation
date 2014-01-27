%w{
  dvd.video
  cd.music
  cd.photo
}.each do |property|
  execute "Ignore #{property} appearing" do
    command "defaults write com.apple.digihub com.apple.digihub.#{property}.appeared -dict action 1"
    user node['current_user']
  end
end
