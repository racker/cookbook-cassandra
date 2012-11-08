
default[:cassandra][:init_style] = "runit"
default[:cassandra][:version] = nil # Required
default[:cassandra][:url] = nil # Required for binary recipe
default[:cassandra][:sha256] = nil # Required for binary recipe

default[:cassandra][:source_url] = nil # Required for source recipe
default[:cassandra][:source_reference] = nil # Required for source recipe

default[:cassandra][:cql][:version] = nil # Required for cql recipe
default[:cassandra][:cql][:base_url] = nil # Required for cql recipe

default[:cassandra][:cluster_name] = nil # Required for default recipe
default[:cassandra][:initial_token] = nil # Required for default recipe

# Specific recipes add to this array since attributes
# are only required for specific recipes
default[:cassandra][:required_attributes] = [
  :version,
  :cluster_name,
  :initial_token
]

default[:cassandra][:mailgun] = false
default[:cassandra][:restart_on_config_change] = false

default[:cassandra][:owner] = "daemon"
default[:cassandra][:group] = "daemon"

default[:cassandra][:log_owner] = "cassandralog"
default[:cassandra][:log_group] = "cassandralog"

default[:cassandra][:crash_email] = "root@localhost"

default[:cassandra][:min_memory] = "2G"
default[:cassandra][:max_memory] = "2G"
default[:cassandra][:replication] = "2"
default[:cassandra][:partitioner] = "org.apache.cassandra.dht.RandomPartitioner"
default[:cassandra][:authenticator] = "org.apache.cassandra.auth.AllowAllAuthenticator"
default[:cassandra][:authority] = "org.apache.cassandra.auth.AllowAllAuthority"
default[:cassandra][:endpoint_snitch] = "org.apache.cassandra.locator.SimpleSnitch"
default[:cassandra][:dynamic_snitch] = "true"
default[:cassandra][:commitlog_sync] = "periodic"
default[:cassandra][:commitlog_sync_period] = 10000
default[:cassandra][:seed_nodes] = []

# Ports
default[:cassandra][:rpc_port] = 9160
default[:cassandra][:storage_port] = 7000
default[:cassandra][:jmx_port] = 8080

# Paths
default[:cassandra][:install_path] = "/opt/cassandra"
default[:cassandra][:releases_path] = "/usr/src/cassandra"
default[:cassandra][:log_path] = "/var/log/cassandra"
default[:cassandra][:commit_log] = "/var/lib/cassandra/commitlog"
default[:cassandra][:saved_caches] = "/var/lib/cassandra/saved_caches"
default[:cassandra][:data_files] = ["/var/lib/cassandra/data"]

default[:cassandra][:down] = false

default[:cassandra][:jvm_options] = %w[
-XX:+UseParNewGC
-XX:+UseConcMarkSweepGC
-XX:+CMSParallelRemarkEnabled
-XX:SurvivorRatio=8
-XX:MaxTenuringThreshold=1
-XX:CMSInitiatingOccupancyFraction=75
-XX:+UseCMSInitiatingOccupancyOnly
-XX:+HeapDumpOnOutOfMemoryError
-Dcom.sun.management.jmxremote.port=8080
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.authenticate=false
-Dcassandra
-Dstorage-config=$CASSANDRA_CONF
-Dcassandra-foreground=yes
-Dcassandra.dynamic_snitch_enabled=true
-Dcassandra.dynamic_snitch=cassandra.dynamic_snitch_enabled
org.apache.cassandra.thrift.CassandraDaemon
]


