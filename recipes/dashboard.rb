directory "#{ENV['HOME']}/Library/Widgets" do
  owner node['current_user']
  recursive true
end
node['dashboard']['widgets'].each do |widget, src|
  tar_extract src do
    target_dir "#{ENV['HOME']}/Library/Widgets"
    creates "#{ENV['HOME']}/Library/Widgets/#{widget}.wdgt"
    user node['current_user']
    group 'staff'
    tar_flags [
      "--exclude '__MACOSX'",
    ]
  end
end