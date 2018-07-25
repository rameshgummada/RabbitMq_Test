#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

if node['platform'] !~ /centos/i
	return
end

bash "importing modules" do
	code <<-EOJ 
	rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	touch /tmp/sam.lock
	EOJ
	not_if "ls  /tmp/sam.lock"
end


package "install packages" do
 	source "https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.1/rabbitmq-server-3.6.1-1.noarch.rpm"
	action :install	
	 provider Chef::Provider::Package::Rpm
end

package %w(erlang epel-release rabbitmq-server) do
	action :install
en

