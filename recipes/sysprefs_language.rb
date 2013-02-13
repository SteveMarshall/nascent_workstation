pivotal_workstation_defaults "Set language to en-GB only" do
  # Expedia explicitly set this, for some reason
  domain 'NSGlobalDomain'
  key 'AppleLanguages'
  array [
    'en-GB'
  ]
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
  '(tab)' => '⇥'
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