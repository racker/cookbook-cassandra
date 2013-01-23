include_recipe "ark"

node[:cassandra][:required_attributes] |= [
  :url,
  :sha256
]

# dont use :initial_token with 1.2.x
node[:cassandra][:required_attributes].delete(:initial_token) if node[:cassandra][:onetwo]
validate_required_attributes(:cassandra)

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
