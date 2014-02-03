include_recipe "nascent_workstation::finder"
include_recipe "nascent_workstation::safari"
include_recipe "nascent_workstation::terminal"
include_recipe "nascent_workstation::messages"

directory "#{ENV['HOME']}/Applications" do
  owner node['current_user']
  recursive true
end

node.apps.each do |name, config|
  destination = config.has_key?('destination') ? config.destination : "#{ENV['HOME']}/Applications"
  if config.has_key?('type') and :dmg == config.type
    dmg_package name do
      volumes_dir config.volumes_dir
      source config.source
      action :install
      owner node['current_user']
      destination destination
      only_if {config.has_key?('source')}
    end
  else
    tar_extract config.source do
      target_dir destination
      creates "#{destination}/#{name}.app"
      user node['current_user']
      group 'staff'
      compress_char config.compress_char if config.has_key?('compress_char')
      only_if {config.has_key?('source')}
    end
  end

  if config.has_key?('symlinks')
    config.symlinks.each do |source, target|
      directory source do
        action :delete
        recursive true
        only_if %Q{test -d "#{source}"}
      end
      file source do
        action :delete
        only_if %Q{test -f "#{source}"}
      end
      link source do
        to target
      end
    end
  end
  if config.has_key?('settings')
    config.settings.each do |k, v|
      next if k == 'domain'

      mac_os_x_userdefaults "#{config.settings['domain']}-#{k}" do
        domain config.settings['domain']
        user node['mac_os_x']['settings_user']
        key k
        value v
      end
    end
  end
end

include_recipe "nascent_workstation::hex_color_picker"

%w{
  Flint
  Tweetbot
  xScope
}.each do |app|
  execute "Move App Store apps to ~/Applications" do
    command %Q{mv /Applications/#{app}.app ~/Applications/#{app}.app}
    only_if "test -d /Applications/#{app}.app"
  end
end
