run_list(
  "role[media]"
)

dock_settings = {
  display_as: {
    stack: 0,
    folder: 1,
  },
  sort_by: {
    name: 0,
    date_added: 2,
    date_modified: 3,
    date_created: 4,
    kind: 5,
  },
  view_contents_as: {
    automatic: 0,
    fan: 1,
    grid: 2,
    list: 3
  }
}

default_attributes(
  sysprefs_users: {
    login_items: [
      "/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app",
      "#{ENV['HOME']}/Applications/Dropbox.app",
    ]
  },
  dock: {
    persistent_apps: [
      "/Applications/Launchpad.app",
      "/Applications/Safari.app",
      "/Applications/iTunes.app",
      "/Applications/Aperture.app",
      "#{ENV['HOME']}/Applications/TextMate.app",
      "/Applications/Utilities/Terminal.app",
    ],
    persistent_others: {
      "#{ENV['HOME']}/Downloads" => {
        :displayas => dock_settings[:display_as][:stack],
        :arrangement => dock_settings[:sort_by][:date_added],
        :showas => dock_settings[:view_contents_as][:automatic],
      },
      "#{ENV['HOME']}/Encoding" => {
        :displayas => dock_settings[:display_as][:folder],
        :arrangement => dock_settings[:sort_by][:name],
        :showas => dock_settings[:view_contents_as][:automatic],
      },
    }
  }
)
