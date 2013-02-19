#!/usr/bin/env bash

# Configure homebrew and rbenv if needs be
if [[ -f /usr/local/bin/brew ]]; then
    brew update
else
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi
if [[ ! -f /usr/local/bin/rbenv ]]; then
    brew install rbenv ruby-build
fi
if [[ ! -f ~/.rbenv/shims/ruby ]]; then
    env CC=/usr/bin/gcc rbenv install 1.9.3-p385
    rbenv global 1.9.3-p385
    rbenv rehash
fi

# Update/grab all the cookbooks
if [[ ! -d ~/cookbooks ]]; then
  mkdir -p ~/cookbooks
  chflags hidden ~/cookbooks
fi

if [[ -d ~/.git ]]; then
  cd && git pull
else
  cd && git clone https://github.com/SteveMarshall/homedir.git && chflags hidden ~/homedir/* && mv ~/homedir/* ~ && mv homedir/.* ~
fi
source .bash_profile
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

if [[ ! -f ~/.rbenv/shims/soloist ]]; then
  gem install soloist
  rbenv rehash
fi
soloist
rm -rf ~/soloistrc