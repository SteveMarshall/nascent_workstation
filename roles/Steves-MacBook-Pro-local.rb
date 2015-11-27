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
  dashboard: {
    widgets: {
      MiniBatteryStatus: "http://www.emeraldion.it/software/download/494/MiniBatteryStatus-2.6.10.zip"
    }
  },
  sysprefs_users: {
    login_items: [
      "/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app",
      "#{ENV['HOME']}/Applications/Dropbox.app",
      "#{ENV['HOME']}/Applications/MercuryMoverAgent.app",
      "#{ENV['HOME']}/Applications/Choosy.app",
      "#{ENV['HOME']}/Library/Application Support/Things Sandbox Helper/Things Helper.app",
    ]
  },
  dock: {
    persistent_apps: [
      "/Applications/Safari.app",
      "/Applications/Mail.app",
      "/Applications/Calendar.app",
      "/Applications/Reminders.app",
      "#{ENV['HOME']}/Applications/Things.app",
      "/Applications/Notes.app",
      "/Applications/Messages.app",
      "#{ENV['HOME']}/Applications/Adium.app",
      "#{ENV['HOME']}/Applications/HipChat.app",
      "#{ENV['HOME']}/Applications/Slack.app",
      "#{ENV['HOME']}/Applications/Tweetbot.app",
      "#{ENV['HOME']}/Applications/TextMate.app",
      "/Applications/Utilities/Terminal.app",
    ],
    persistent_others: {
      "#{ENV['HOME']}/Downloads" => {
        :displayas => dock_settings[:display_as][:stack],
        :arrangement => dock_settings[:sort_by][:date_added],
        :showas => dock_settings[:view_contents_as][:automatic],
      },
      "#{ENV['HOME']}/Dropbox/Documents/Home" => {
        :displayas => dock_settings[:display_as][:folder],
        :arrangement => dock_settings[:sort_by][:name],
        :showas => dock_settings[:view_contents_as][:automatic],
      },
      "#{ENV['HOME']}/Dropbox/Documents/Work" => {
        :displayas => dock_settings[:display_as][:folder],
        :arrangement => dock_settings[:sort_by][:name],
        :showas => dock_settings[:view_contents_as][:automatic],
      },
    }
  }
)
run_list(
  "role[development]",
  "recipe[nascent_workstation::sysprefs_energy]",
)
