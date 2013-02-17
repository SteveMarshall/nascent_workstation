include_recipe "nascent_workstation::utils"

include_recipe "nascent_workstation::sysprefs_general"
include_recipe "nascent_workstation::sysprefs_desktop"
include_recipe "nascent_workstation::sysprefs_dock"
# Unneeded: Misson control
include_recipe "nascent_workstation::sysprefs_language"
include_recipe "nascent_workstation::sysprefs_security"
# TODO: Notifications
include_recipe "nascent_workstation::sysprefs_cds_and_dvds"
# Unneeded?: CDs & DVDs; Displays
include_recipe "nascent_workstation::sysprefs_energy"
include_recipe "nascent_workstation::sysprefs_keyboard"
# Unneeded?: Mouse; Trackpad; Print & Scan; Sound
# TODO: iCloud; Mail, Contacts & Calendars
# Unneeded?: Network; Bluetooth
include_recipe "nascent_workstation::sysprefs_sharing"
include_recipe "nascent_workstation::sysprefs_users"
# Unneeded?: Parental Controls; Date & Time; Software Update; Dictation & Speech; Time Machine
include_recipe "nascent_workstation::sysprefs_accessibility"
# Unneeded?: Startup Disk