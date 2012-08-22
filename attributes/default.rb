
default[:cassandra][:install_flavor] = "binary"
default[:cassandra][:init_style] = "init"
default[:cassandra][:version] = ""
default[:cassandra][:url] = ""

default[:cassandra][:source_url] = ""
default[:cassandra][:source_reference] = ""

default[:cassandra][:cql][:version] = ""
default[:cassandra][:cql][:base_url] = ""

default[:cassandra][:user] = "daemon"
default[:cassandra][:group] = "daemon"

default[:cassandra][:log_owner] = "cassandralog"
default[:cassandra][:log_group] = "cassandralog"

default[:cassandra][:min_memory] = "2G"
default[:cassandra][:max_memory] = "2G"
default[:cassandra][:cluster_name] = ""
default[:cassandra][:initial_token] = ""
default[:cassandra][:replication] = "2"
default[:cassandra][:partitioner] = "org.apache.cassandra.dht.RandomPartitioner"
default[:cassandra][:authenticator] = "org.apache.cassandra.auth.AllowAllAuthenticator"
default[:cassandra][:authority] = "org.apache.cassandra.auth.AllowAllAuthority"
default[:cassandra][:endpoint_snitch] = "org.apache.cassandra.locator.SimpleSnitch"
default[:cassandra][:dynamic_snitch] = "true"
default[:cassandra][:commitlog_sync] = "periodic"
default[:cassandra][:commitlog_sync_period] = 10000
default[:cassandra][:seed_nodes] = []

# Networking
default[:cassandra][:rpc_interface] = ""
default[:cassandra][:rpc_port] = 9160
default[:cassandra][:storage_interface] = ""
default[:cassandra][:storage_port] = 7000
default[:cassandra][:jmx_interface] = ""
default[:cassandra][:jmx_port] = 8080

# Paths
default[:cassandra][:install_path] = "/opt/cassandra"
default[:cassandra][:log_path] = "/var/log/cassandra"
default[:cassandra][:commit_log] = "/var/lib/cassandra/commitlog"
default[:cassandra][:saved_caches] = "/var/lib/cassandra/saved_caches"
default[:cassandra][:data_files] = ["/var/lib/cassandra/data"]


default[:cassandra][:jvm_options] = %W[
-XX:+UseParNewGC
-XX:+UseConcMarkSweepGC
-XX:+CMSParallelRemarkEnabled
-XX:SurvivorRatio=8
-XX:MaxTenuringThreshold=1
-XX:CMSInitiatingOccupancyFraction=75
-XX:+UseCMSInitiatingOccupancyOnly
-XX:+HeapDumpOnOutOfMemoryError
-Dcom.sun.management.jmxremote.port=#{node[:cassandra][:jmx_port]}
-Dcom.sun.management.jmxremote.ssl=false
-Dcom.sun.management.jmxremote.authenticate=false
-Dcassandra
-Dstorage-config=$CASSANDRA_CONF
-Dcassandra-foreground=yes
-Dcassandra.dynamic_snitch_enabled=true
-Dcassandra.dynamic_snitch=cassandra.dynamic_snitch_enabled
org.apache.cassandra.thrift.CassandraDaemon
]

