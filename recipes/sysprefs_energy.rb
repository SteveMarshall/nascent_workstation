execute "Set battery power settings" do
  command "pmset -b displaysleep 15 sleep 30"
end
execute "Set adapter power settings" do
  command "pmset -c displaysleep 30 sleep 0"
end

# HACK: Fix slow wake for Retina MBP
# http://www.ewal.net/2012/09/09/slow-wake-for-macbook-pro-retina/

standbydelay = 12 * 60 * 60
execute "pmset -a standbydelay #{standbydelay}"
