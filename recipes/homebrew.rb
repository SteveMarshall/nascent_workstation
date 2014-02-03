if node['homebrew']
  if node['homebrew']['taps']
    node['homebrew']['taps'].each do |tap|
      homebrew_tap tap
      tap_dir = tap.gsub('/', '-')
      directory "/usr/local/Library/Taps/#{tap_dir}" do
        owner node['current_user']
        recursive true
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
