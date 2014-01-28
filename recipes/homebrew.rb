if node['homebrew']
  if node['homebrew']['taps']
    node['homebrew']['taps'].each do |tap|
      homebrew_tap tap
      tap_dir = tap.gsub('/', '-')
      execute "fix #{tap} permissions" do
        command "chown -R #{node['current_user']} /usr/local/Library/Taps/#{tap_dir}"
      end
    end
  end

  if node['homebrew']['packages']
    node['homebrew']['packages'].each do |pkg, opt|
      package pkg do
        options opt
      end
    end
  end
end
