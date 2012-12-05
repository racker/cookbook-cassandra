
require 'digest/md5'

# Slightly modified from Puppet's fqdn_rand function
srand(Digest::MD5.hexdigest(node['fqdn']).to_i(16))
hour = rand(24)
min = rand(60)

cron "cassandra_cleanup" do
  hour hour
  minute min
  command "#{node[:cassandra][:install_path]}/bin/nodetool cleanup"
  EOF
end

# Run compact 6 hours later
cron "cassandra_compact" do
  hour ((hour + 6) % 24)
  minute min
  command "#{node[:cassandra][:install_path]}/bin/nodetool compact"
end

