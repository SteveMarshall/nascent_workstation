#!/usr/bin/env bash

# Configure homebrew and rbenv if needs be
if [[ -f /usr/local/bin/brew ]]; then
    brew update
else
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi
if [[ ! -f /usr/local/bin/rbenv ]]; then
    brew install rbenv
fi
if [[ ! -f /Users/smarshall/.rbenv/shims/ruby ]]; then
    rbenv install 1.9.3-p327
    rbenv rehash
fi

# Update/grab all the cookbooks
if [[ ! -d ~/cookbooks ]]; then
  mkdir -p ~/cookbooks
fi

if [[ -d ~/cookbooks/pivotal_workstation ]]; then
  cd ~/cookbooks/pivotal_workstation && git pull
else
  cd ~/cookbooks && git clone https://github.com/SteveMarshall/pivotal_workstation.git
fi
if [[ -d ~/cookbooks/dmg ]]; then
  cd ~/cookbooks/dmg && git pull
else
  cd ~/cookbooks && git clone https://github.com/opscode-cookbooks/dmg.git
fi

# Bootstrap using soloist
cd ~/cookbooks
cat > ~/soloistrc <<EOF
cookbook_paths:
- cookbooks
recipes:
- nascent_workstation::sysprefs
- nascent_workstation::apps
EOF

# TODO: Ensure we've got rbenv?
gem install soloist
rbenv rehash
soloist