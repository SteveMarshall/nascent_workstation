name "media"
description "Things I need for media management"

run_list(
  "role[base]",
  "recipe[nascent_workstation::packages]",
)

default_attributes(
  homebrew: {
    packages: {
      'atomicparsley' => nil,
      'aspell'        => ['--lang=en'],
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
