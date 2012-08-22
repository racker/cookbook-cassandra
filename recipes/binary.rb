
install_path = node[:cassandra][:install_path]
cass_version = node[:cassandra][:version]

bash "extract_cassandra" do
  cwd "/usr/src"
  code <<-EOH
    tar zxf cassandra-#{cass_version}-bin.tar.gz
    rm -rf #{install_path}
    mkdir -p #{install_path}
    cp -r cassandra-#{cass_version}/* #{install_path}/
    cp cassandra-#{cass_version}/build/lib/jars/jna-*.jar #{install_path}/lib/
  EOH
  action :nothing
end

remote_file "/usr/src/cassandra-#{cass_version}-bin.tar.gz" do
  source node[:cassandra][:url]
  mode "644"
  action :create_if_missing
  notifies :run, "bash[extract_cassandra]"
end

