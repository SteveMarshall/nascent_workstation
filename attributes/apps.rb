node.default["hex_color_picker"]["source"] = "http://wafflesoftware.net/hexpicker/download/"
node.default["hex_color_picker"]["destination"] = "#{ENV['HOME']}/Library/ColorPickers/"

node.default["quicklook"]["markdown"]["source"] = "https://github.com/downloads/toland/qlmarkdown/QLMarkdown-1.3.zip"
node.default["quicklook"]["markdown"]["destination"] = "#{ENV['HOME']}/Library/QuickLook/"

node.default["dashboard"]["widgets"] = {
  "Delivery Status"   => "http://junecloud.com/get/delivery-status-widget",
  "MiniBatteryStatus" => "http://www.emeraldion.it/software/download/494/MiniBatteryStatus-2.6.10.zip",
}
