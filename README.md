Description
===========

Installs and configures a Cassandra node

Recipes
=======

default
-------

Not meant to be called by itself. This recipe should get called by either the binary or source recipes. This recipe will set up paths, services, and dependencies once the type of Cassandra node is installed correctly.

binary
------

This recipe will grab a binary build of Cassandra as specified by the node[:cassandra][:url] then install it to the node[:cassandra][:install_path]. Afterwards it calls the default recipe to do the general setup.

source
------

To use this recipe specify a node[:cassandra][:source_url] and node[:cassandra][:source_reference]. It will then do a pull the git source from the source_url into the node[:cassandra][:install_path], then run the ant build, then call the default recipe to do the general setup.

cql
---

If you need the python cql driver and the cqlsh commandline tool installed add this recipe to your node/role.

Usage
=====

The expected usage would be to add either the cassandra::binary or cassandra::source to your node or role and it just magically works.

Known Issues
============

Currently the cookbook doesn't detect the version it just checks for the existance of a /data/cassandra directory and skips the install if it exists. Obviously this is non-optimal but I haven't come up with a good way to allow it to upgrade without restarting Cassandra on every Chef run.
