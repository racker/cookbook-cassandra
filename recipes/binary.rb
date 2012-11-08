
install_path = node[:cassandra][:install_path]
releases_path = node[:cassandra][:releases_path]
cass_version = node[:cassandra][:version]

node[:cassandra][:required_attributes] |= [
  :url,
  :sha256
]
validate_required_attributes(:cassandra)

directory releases_path do
  owner node[:cassandra][:owner]
  group node[:cassandra][:group]
  mode 0755
  recursive true
end

link install_path do
  to "#{releases_path}/apache-cassandra-#{cass_version}"
  action :nothing
end

bash "extract_cassandra" do
  cwd releases_path
  code <<-EOH
    tar zxf cassandra-#{cass_version}-bin.tar.gz \
      || (rm -rf apache-cassandra-#{cass_version} && false)
  EOH
  action :nothing
  notifies :create, "link[#{install_path}]", :immediately
end

remote_file "#{releases_path}/cassandra-#{cass_version}-bin.tar.gz" do
  source node[:cassandra][:url]
  mode "644"
  action :create_if_missing
  checksum node[:cassandra][:sha256]
  notifies :run, "bash[extract_cassandra]", :immediately
end

include_recipe "cassandra"
