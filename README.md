Running!
========

    bash <(curl -s https://raw.github.com/SteveMarshall/nascent_workstation/master/bin/bootstrap)

TODO
====

- Don't run chef-solo using sudo? (How do we edit sudoers/pmset without that?)
- Configure apps
  - Link stuff to Dropbutt
- Folder icons (/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources?; http://apple.stackexchange.com/questions/6901/how-can-i-change-a-file-or-folder-icon-using-the-terminal/6905#6905)
- Compare with Apple defaults
- Install other apps (notably, app store ones + VMW Fusion + Chrome)?
  - Install/Move Chrome to ~/Applications
- Configure Dropbox
- Licensing? + accounts
- Tidy launchpad
- Configure Dashboard
- Evaluate uses of mac_os_x_userdefaults:delete
- Migrate defaults settings into roles with node.default['mac_os_x']['settings'] = {}
- Remove/reduce execute et al.
