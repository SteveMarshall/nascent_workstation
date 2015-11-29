node['homebrew']['taps'].each do |tap|
  homebrew_tap tap
end

node['homebrew']['casks'].each do |cask|
  homebrew_cask cask
end

node['homebrew']['formulas'].each do |formula|
  if formula.class == Chef::Node::ImmutableMash
    package formula.fetch(:name) do
      options '--HEAD' if formula.fetch(:head, false)
      version formula['version'] if formula.fetch(:version, false)
    end
  else
    package formula
  end
end
