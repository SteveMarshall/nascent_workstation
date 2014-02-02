node.default["adium"]["source"]="http://sourceforge.net/projects/adium/files/Adium_1.5.4.dmg/download"
node.default["adium"]["destination"]="#{ENV['HOME']}/Applications"

node.default["dropbox"]["source"]="https://www.dropbox.com/download?plat=mac"
node.default["dropbox"]["destination"]="#{ENV['HOME']}/Applications"

node.default["transmit"]["source"]="http://www.panic.com/transmit/d/Transmit%204.4.5.zip"
node.default["transmit"]["destination"]="#{ENV['HOME']}/Applications"

node.default["hex_color_picker"]["source"] = "http://wafflesoftware.net/hexpicker/download/"
node.default["hex_color_picker"]["destination"] = "#{ENV['HOME']}/Library/ColorPickers/"

node.default["textmate"]["source"]="https://github.com/textmate/textmate/releases/download/v2.0-alpha.9503/TextMate_2.0-alpha.9503.tbz"
node.default["textmate"]["destination"]="#{ENV['HOME']}/Applications"
node.default["textmate"]["cmd_destination"] = "#{ENV['HOME']}/bin"
# node.default["things"]["destination"]="#{ENV['HOME']}/Applications"

node.default["quicklook"]["markdown"]["source"] = "https://github.com/downloads/toland/qlmarkdown/QLMarkdown-1.3.zip"
node.default["quicklook"]["markdown"]["destination"] = "#{ENV['HOME']}/Library/QuickLook/"
