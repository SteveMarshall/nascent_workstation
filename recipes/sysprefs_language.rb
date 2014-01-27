mac_os_x_userdefaults "Set language to en-GB only" do
  user node['current_user']
  domain 'NSGlobalDomain'
  global true
  key 'AppleLanguages'
  type 'array'
  value [
    'en-GB'
  ]
end

mac_os_x_userdefaults "Set region to en-GB" do
  user node['current_user']
  domain 'NSGlobalDomain'
  global true
  key 'AppleLocale'
  value 'en_GB'
  type 'string'
  notifies :run, "execute[restart SystemUIServer]"
end

# HACK: Reset the clock to force it back to current region
execute "Reset clock to regional defaults" do
  command "defaults delete com.apple.menuextra.clock"
  notifies :run, "execute[restart SystemUIServer]"
  # TODO: use only_if instead of just ignoring
  ignore_failure true
  user node['current_user']
end

mac_os_x_userdefaults "Use metric units" do
  user node['current_user']
  domain 'NSGlobalDomain'
  global true
  key 'AppleMetricUnits'
  value 'TRUE'
  type 'bool'
end

# HACK: Use real UTF8 entities instead of escapes
replacements = {
  '(c)' => '©',
  '(r)' => '®',
  '(p)' => '℗',
  'TM' => '™',
  'c/o' => '℅',
  '...' => '…',
  '1/2' => '½',
  '1/3' => '⅓',
  '2/3' => '⅔',
  '1/4' => '¼',
  '3/4' => '¾',
  '1/8' => '⅛',
  '3/8' => '⅜',
  '5/8' => '⅝',
  '7/8' => '⅞',
  '(cmd)' => '⌘',
  '(opt)' => '⌥',
  '(ctrl)' => '⌃',
  '(shift)' => '⇧',
  '(caps)' => '⇪',
  '(eject)' => '⏏',
  '(up)' => '↑',
  '(down)' => '↓',
  '(left)' => '←',
  '(right)' => '→',
  '(mult)' => '×',
  '(tab)' => '⇥',
  '(enter)' => '⏎',
  # TODO: Add emoji replacements, per github.com/gregburek/github-emoji-expansion-in-osx
}.map{ |replace, with|
  # HACK: Use XML plist format, because json doesn't handle `on` properly
  "<dict>
    <key>on</key>
    <integer>1</integer>
    <key>replace</key>
    <string>#{replace}</string>
    <key>with</key>
    <string>#{with}</string>
  </dict>"
}
mac_os_x_userdefaults "Create my text replacements" do
  user node['current_user']
  domain 'NSGlobalDomain'
  global true
  key 'NSUserReplacementItems'
  type 'array'
  value replacements
end

# TODO: Set keyboard layout
# (smarshall@LONC02K22ZTDKQ4 cookbooks/nasc…tion)$ defaults -currentHost read com.apple.HIToolbox
# {
#     AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.British";
#     AppleDateResID =     {
#         smRoman = 2;
#     };
#     AppleEnabledInputSources =     (
#                 {
#             InputSourceKind = "Keyboard Layout";
#             "KeyboardLayout ID" = 2;
#             "KeyboardLayout Name" = British;
#         }
#     );
#     AppleInputSourceHistory =     (
#                 {
#             InputSourceKind = "Keyboard Layout";
#             "KeyboardLayout ID" = 2;
#             "KeyboardLayout Name" = British;
#         },
#                 {
#             InputSourceKind = "Keyboard Layout";
#             "KeyboardLayout ID" = 0;
#             "KeyboardLayout Name" = "U.S.";
#         }
#     );
#     AppleNumberResID =     {
#         smRoman = 2;
#     };
#     AppleSelectedInputSources =     (
#                 {
#             InputSourceKind = "Keyboard Layout";
#             "KeyboardLayout ID" = 2;
#             "KeyboardLayout Name" = British;
#         }
#     );
#     AppleTimeResID =     {
#         smRoman = 2;
#     };
# }
