#
# Cookbook Name:: cassandra
# Recipe:: default
#
# Copyright 2011, Rackspace
#
# All rights reserved - Do Not Redistribute
#
include_recipe "java"
include_recipe "runit"

if node[:cassandra][:mailgun]
  include_recipe "mailgun"
  mailgun "cassandra_config_change" do
    subject "Cassandra config changed on #{node[:fqdn]}"
    body "Cassandra config changed at #{Time.now} on #{node[:fqdn]} and requires a restart"
    action :nothing
  end
end

validate_required_attributes(:cassandra)

%w{libjna-java ant}.each do |pkg|
  package pkg
end

install_path = node[:cassandra][:install_path]
releases_path = node[:cassandra][:releases_path]
service_user = node[:cassandra][:owner]
service_group = node[:cassandra][:group]

paths = [
  install_path,
  releases_path,
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

seed_nodes = node[:cassandra][:seed_nodes].dup
seed_nodes.delete(node[:cassandra][:listen_ip])

template "#{install_path}/conf/cassandra.yaml" do
  owner service_user
  group service_group
  mode "644"
  source node[:cassandra][:config_template]
  variables(
    :cassandra_seed_nodes => seed_nodes.join(",")
  )

  if node[:cassandra][:restart_on_config_change]
    notifies :restart, "runit_service[cassandra]", :delayed
  end

  if node[:cassandra][:mailgun]
    notifies :create, "mailgun[cassandra_config_change]", :delayed
  end
end

%w[
  jna.jar
  jna-platform.jar
].each do |jar|
  link File.join(install_path, "lib", jar) do
    to "/usr/share/java/#{jar}"
    only_if { File.exists?("/usr/share/java/#{jar}") }
  end
end

runit_service "cassandra" do
  default_logger true
  if node[:cassandra][:max_heap_size] && node[:cassandra][:heap_newsize]
    options({
      :has_env => true
    })
    env({
      "MAX_HEAP_SIZE" => node[:cassandra][:max_heap_size],
      "HEAP_NEWSIZE" => node[:cassandra][:heap_newsize]
    })
  end
end

