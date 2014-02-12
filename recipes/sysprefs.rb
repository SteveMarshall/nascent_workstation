include_recipe "nascent_workstation::utils"

include_recipe "nascent_workstation::sysprefs_desktop"
# Unneeded: Misson control
include_recipe "nascent_workstation::dashboard"
# TODO: Notifications
include_recipe "nascent_workstation::sysprefs_cds_and_dvds"
# Unneeded?: Displays
# Unneeded: Mouse; Trackpad; Print & Scan; Sound
# TODO: iCloud; Mail, Contacts & Calendars
# Unneeded: Network; Bluetooth
include_recipe "nascent_workstation::sysprefs_sharing"
include_recipe "nascent_workstation::sysprefs_users"
# Unneeded: Parental Controls; Date & Time; Software Update; Dictation & Speech; Time Machine
# Unneeded: Accessibility?
# Unneeded: Startup Disk
