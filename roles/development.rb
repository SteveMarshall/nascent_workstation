name "development"
description "Things I need for development"

run_list(
  "role[base]",
  "recipe[nascent_workstation::apps]",
)

default_attributes(
  homebrew: {
    taps: ['homebrew/binary'],
    packages: {
      'packer' => nil,
    }
  }
)
