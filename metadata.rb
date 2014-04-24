maintainer       "Rackspace"
maintainer_email "cooks@lists.rackspace.com"
license          "All rights reserved"
description      "Installs/Configures Cassandra"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.7"

recipe           "cassandra", ""
recipe           "cassandra::source", "Installs Cassandra from source"
recipe           "cassandra::binary", "Installs Cassandra from a binary package"

supports "ubuntu"

%w{java required_attributes mailgun python ark}.each do |cb|
  depends cb
end

depends "runit", ">= 1.0.0"
