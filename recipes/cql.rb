cql_version = node[:cassandra][:cql][:version]
base_url = node[:cassandra][:cql][:base_url]

package "python-thrift"

remote_file "/usr/src/cql-#{cql_version}.tar.gz" do
  source "#{base_url}/cql-#{cql_version}.tar.gz"
  mode "644"
  action :create_if_missing
end

execute "extract_cql" do
  not_if do
    File.exist? "/usr/src/cql-#{cql_version}"
  end
  cwd "/usr/src"
  command "tar zxf cql-#{cql_version}.tar.gz \
    || (rm cql-#{cql_version} && false)"
  action :run
end

execute "install_cqlsh" do
  # TODO: Check for existence and skip install
  not_if do
  end
  command "python setup.py install -f"
  cwd "/usr/src/cql-#{cql_version}"
  action :run
end
