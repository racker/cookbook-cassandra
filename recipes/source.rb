#
# Cookbook Name:: cassandra
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cass_version = node[:cassandra][:version]
install_path = node[:cassandra][:install_path]

node.normal[:cassandra][:required_attributes] |= [
  :source_url,
  :source_reference
]
validate_required_attributes(:cassandra)

execute "ant_build" do
  command "ant"
  cwd "#{install_path}"
  action :nothing
end

git "#{install_path}" do
  repository node[:cassandra][:source_url]
  reference node[:cassandra][:source_reference]
  action :sync
  notifies :run, "execute[ant_build]", :immediately
end

include_recipe "cassandra"
