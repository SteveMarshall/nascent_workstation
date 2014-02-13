name "media"
description "Things I need for media management"

run_list(
  "role[base]",
)

default_attributes(
  apps: {
    # TODO: myDVDEdit?
    # TODO: MTR4?
    # TODO: Airfoil speakers?
    DVD2oneX2: {
      source: 'http://www.dvd2one.com/files/dvd2onex242.zip',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
    HandBrake: {
      source: 'http://downloads.sourceforge.net/project/handbrake/0.9.9/HandBrake-0.9.9-MacOSX.6_GUI_x86_64.dmg?r=&ts=1392292307&use_mirror=heanet',
      type: :dmg,
      volumes_dir: 'HandBrake-0.9.9-MacOSX.6_GUI_x86_64',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
    MagicDVDRipper: {
      source: 'http://mac.magicdvdripper.com/download/MagicDVDRipper.zip',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
    MDRP: {
      source: 'http://www.macdvdripperpro.com/download/',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
    RipIt: {
      source: 'http://files.thelittleappfactory.com/ripit/RipIt.zip',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
    Subler: {
      source: 'http://subler.googlecode.com/files/Subler-0.25.zip',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
    Transmission: {
      source: 'http://download.transmissionbt.com/files/Transmission-2.82.dmg',
      type: :dmg,
      volumes_dir: 'Transmission',
    },
    VLC: {
      source: 'http://get.videolan.org:81/vlc/2.1.3/macosx/vlc-2.1.3.dmg',
      type: :dmg,
      volumes_dir: 'vlc-2.1.3',
      destination: "#{ENV['HOME']}/Applications/Ripping",
    },
  },
  home: {
    directories: [
      'Applications/Ripping',
    ]
  },
  homebrew: {
    packages: {
      'atomicparsley' => nil,
      'aspell'        => '--lang=en',
      'dvdauthor'     => nil, # Allows unmuxing of subs from DVDs
      'imagemagick'   => nil, # Allows conversion of images for OCRing
      'netpbm'        => nil, # Allow gocr to work directly with PNG
      'gocr'          => nil, # OCR library
    }
  },
  perl: {
    modules: [
      # p5-Media dependencies
      'IMDB::Film',
      'WebService::MusicBrainz',
    ],
  },
)
