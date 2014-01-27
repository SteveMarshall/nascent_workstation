name "development"
description "Things I need for development"

run_list(
  "recipe[nascent_workstation::apps]",
  "recipe[nascent_workstation::home]"
)
