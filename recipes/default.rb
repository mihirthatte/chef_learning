#
# Cookbook:: my_first
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


#Create a directory - 
directory '/var/tmp/generator' do
	owner 'vagrant'
	group 'vagrant'
	mode '0755'
	action :create
end

#Installing httpd, and java-1.8-sdk -
package ['httpd', 'epel-release', 'java-1.8.0-openjdk-devel'] do
	action :install
end

package 'python-pip'

#Installing Elasticsearch - 
template '/etc/yum.repos.d/elasticsearch.repo' do
        source 'elasticsearch.repo.erb'
end
package 'elasticsearch'


#Enabling services - 
services = ['httpd', 'elasticsearch']
for every_service in services
	service every_service do
		action [:enable, :start]
	end
end

#Placing template files - 

template '/var/www/html/index.html' do
        source 'index.html.erb'
        mode   '0755'
        owner  'vagrant'
        group  'vagrant'
end

template '/var/tmp/generator/populate_data.py' do
        source 'populate_data.py.erb'
	mode   '0755'
	owner  'vagrant'
	group  'vagrant'
end

#Installing python modules - elasticsearch and request
execute 'install pip packages' do
	command 'pip install elasticsearch'
end

execute 'install pip packages' do
	command 'pip install requests'
end

#Creating a cron job to invoke the script every 5 hours
cron 'python script' do
	hour '5'
	minute '0'
	command 'python /var/tmp/generator/populate_data.py'
end
