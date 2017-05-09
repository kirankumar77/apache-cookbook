#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'apache2' 

package 'unzip'


cookbook_file '/var/www/html/site.zip' do
source 'site.zip'
mode '0755'
owner 'root'
group node['apache']['root_group']
end

bash "extracting files" do
cwd "/var/www/html"
code <<-EOH
unzip site.zip
EOH
not_if {File.exists?("/var/www/html/images")}
end

template "/var/www/html/index.html" do
source "index.html.erb"
mode '0644'
owner 'root'
group node['apache']['root_group']
end

