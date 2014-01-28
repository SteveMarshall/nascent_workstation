name "development"
description "Things I need for development"

run_list(
  "role[base]",
  "recipe[nascent_workstation::homebrew]",
  "recipe[nascent_workstation::apps]",
  "recipe[nascent_workstation::home]"
)

default_attributes(
  homebrew: {
    taps: ['homebrew/binary'],
    packages: {
      'packer' => nil,
    }
  }
)
