include_recipe "nascent_workstation::finder"
include_recipe "nascent_workstation::safari"
include_recipe "nascent_workstation::terminal"

directory "#{ENV['HOME']}/Applications" do
  owner ENV['SUDO_USER']
  recursive true
end

node['apps'].each do |name, config|
  destination = config.has_key?('destination') ? config.destination : "#{ENV['HOME']}/Applications"
  if config.has_key?('type') and :dmg == config.type and config.has_key?('source')
    dmg_package name do
      volumes_dir config.volumes_dir
      source config.source
      action :install
      owner ENV['SUDO_USER']
      destination destination
    end
  elsif config.has_key?('source')
    tar_extract config.source do
      target_dir destination
      creates "#{destination}/#{name}.app"
      user ENV['SUDO_USER']
      group 'staff'
      compress_char config.compress_char if config.has_key?('compress_char')
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
