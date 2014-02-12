run_list(
  "role[media]"
)

default_attributes(
  sysprefs_users: {
    login_items: [
      "/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app",
      "#{ENV['HOME']}/Applications/Dropbox.app",
    ]
  }
)
