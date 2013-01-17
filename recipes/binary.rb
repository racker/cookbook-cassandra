include_recipe "ark"

node[:cassandra][:required_attributes] |= [
  :url,
  :sha256
]
validate_required_attributes(:cassandra)

ark "cassandra" do
  url node[:cassandra][:url]
  checksum node[:cassandra][:sha256]
  version node[:cassandra][:version]
  prefix_root "/opt"
  prefix_home "/opt"
  home_dir node[:cassandra][:install_path]
  path node[:cassandra][:path]
  owner node[:cassandra][:owner]
  action :install
end

include_recipe "cassandra"
