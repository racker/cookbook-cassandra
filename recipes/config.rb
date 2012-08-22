#
# Cookbook Name:: cassandra
# Recipe:: default
#
# Copyright 2011, Rackspace
#
# All rights reserved - Do Not Redistribute
#

cass_version = node[:cassandra][:version]
install_path = node[:cassandra][:install_path]
service_user = node[:cassandra][:user]
service_group = node[:cassandra][:group]

paths = [
  install_path,
  node[:cassandra][:log_path],
  node[:cassandra][:commit_log],
  node[:cassandra][:saved_caches]
] | node[:cassandra][:data_files]

paths.each do |path|
  directory path do
    owner service_user
    group service_group
    mode 0755
    recursive true
  end
end

directory "#{install_path}/conf" do
  owner service_user
  group service_group
  mode "755"
end

cookbook_file "#{install_path}/conf/log4j.properties" do
  owner service_user
  group service_group
  mode "644"
  source "log4j-server.properties"
end

template "#{install_path}/conf/cassandra.yaml" do
  owner service_user
  group service_group
  mode "644"
  source "cassandra.yaml.erb"
  variables(
    :cassandra_seed_nodes => cassandra_seed_nodes
  )
  notifies :restart, "service[cassandra]", :delayed
end

runit_service "cassandra" do
  log_owner node[:cassandra][:log_owner]
  log_group node[:cassandra][:log_group]
  down node[:cassandra][:down]
  env({
    :HOME => "/usr/sbin",
    :PATH => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:"
  })
end

