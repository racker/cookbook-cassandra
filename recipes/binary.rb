include_recipe "ark"

ark "cassandra" do
  url node[:cassandra][:url]
  checksum node[:cassandra][:sha256]
  version node[:cassandra][:version]
  prefix_root node[:cassandra][:prefix]
  prefix_home node[:cassandra][:prefix]
  home_dir node[:cassandra][:install_path]
  path node[:cassandra][:path]
  owner node[:cassandra][:owner]
  action :install
end

include_recipe "cassandra"
