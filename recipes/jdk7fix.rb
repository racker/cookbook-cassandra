# Java 7u40 requires a stack size of 288k
# Cassandra doesn't currently set that
# https://issues.apache.org/jira/browse/CASSANDRA-5895
ruby_block "fix_cassandra_xss" do
  block do
    config_path = ::File.join(node['cassandra']['install_path'], 'conf', 'cassandra-env.sh')
    f = Chef::Util::FileEdit.new(config_path)
    f.search_file_replace(/Xss180k/, 'Xss228k')
    f.write_file
  end
end
