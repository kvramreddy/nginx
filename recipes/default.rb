#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'apt'
package 'nginx'

template '/usr/share/nginx/html/index.html' do
  source 'index.html.erb'
  mode '0644'
end

directory '/etc/nginx' do
  owner 'root'
  group 'root'
  mode 0755
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  # notifies :restart, 'service[nginx]', :immediately
end

template '/etc/nginx/sites-available/default' do
  source 'default.conf.erb'
  notifies :restart, 'service[nginx]', :immediately
end

service 'nginx' do
  supports restart: true, reload: true, status: true
  provider Chef::Provider::Service::Init::Systemd
  action [:enable, :start]
end
