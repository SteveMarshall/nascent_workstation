if node['perl'] and node['perl']['modules']
  node['perl']['modules'].each do |pkg|
    # HACK: perl::cpan_module doesn't install as current_user
    execute "install-#{pkg}" do
     command "su #{ENV['SUDO_USER']} -l -c '#{node['perl']['cpanm']['path']} --notest #{pkg}'"
     not_if %Q{su #{ENV['SUDO_USER']} -l -c "perl -m#{pkg} -e ''"}
    end
  end
end
