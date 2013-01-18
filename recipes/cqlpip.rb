include_recipe "python"
package "python-thrift"

python_pip "cql" do
  version node[:cassandra][:cql][:version]
  action :install
end
