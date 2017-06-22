#
# Cookbook Name:: apache_rhel7
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
 action :install
end

package "mod_ssl" do
 action :install
end

directory "/etc/ssl/private" do
 action :create
 mode 0700
end

template "/etc/httpd/conf/httpd.conf" do
 source "httpd.conf.erb"
 notifies :restart, 'service[httpd]', :immediately
end

template "/var/www/html/index.html" do
 source "index.html.erb"
 notifies :restart, 'service[httpd]', :immediately
end

template "/etc/httpd/conf.d/non-ssl.conf" do
 source "non-ssl.conf.erb"
 notifies :restart, 'service[httpd]', :immediately
end

template "/etc/httpd/conf.d/ssl.conf" do
 source "ssl.conf.erb"
 notifies :restart, 'service[httpd]', :immediately
end


cookbook_file "/etc/ssl/certs/apache-selfsigned.crt" do
   source "apache-selfsigned.crt"
   mode "0644"
   owner "root"
 notifies :restart, 'service[httpd]', :immediately
end

cookbook_file "/etc/ssl/private/apache-selfsigned.key" do
   source "apache-selfsigned.key"
   mode "0644"
   owner "root"
 notifies :restart, 'service[httpd]', :immediately
end

service "httpd" do
 action [:enable, :start]
end

