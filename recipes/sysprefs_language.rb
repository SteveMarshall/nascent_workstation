pivotal_workstation_defaults "Set language to en-GB only" do
  domain 'NSGlobalDomain'
  key 'AppleLanguages'
  array [
    'en-GB'
  ]
end

pivotal_workstation_defaults "Set region to en-GB" do
  domain 'NSGlobalDomain'
  key 'AppleLocale'
  string 'en_GB'
  notifies :run, "execute[restart SystemUIServer]"
end

# HACK: Reset the clock to force it back to current region
execute "Reset clock to regional defaults" do
  command "defaults delete com.apple.menuextra.clock"
  notifies :run, "execute[restart SystemUIServer]"
  # TODO: use only_if instead of just ignoring
  ignore_failure true
  user WS_USER
end

pivotal_workstation_defaults "Use metric units" do
  domain 'NSGlobalDomain'
  key 'AppleMetricUnits'
  boolean true
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
pivotal_workstation_defaults "Create my text replacements" do
  domain 'NSGlobalDomain'
  key 'NSUserReplacementItems'
  array replacements
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
