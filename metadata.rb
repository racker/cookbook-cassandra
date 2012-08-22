maintainer       "Rackspace"
maintainer_email "cooks@lists.rackspace.com"
license          "All rights reserved"
description      "Installs/Configures Cassandra"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe           "cassandra", "Installs Cassandra based on the node[:cassandra][:install_flavor] attribute"
recipe           "cassandra::source", "Installs Cassandra from source"
recipe           "cassandra::binary", "Installs Cassandra from a binary package"
recipe           "cassandra::config", "Sets up configuration for Cassandra"

supports "ubuntu", "= 10.04"

%w{java boost thrift}.each do |cb|
  depends cb
end
