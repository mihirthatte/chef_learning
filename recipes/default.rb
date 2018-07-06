#
# Cookbook:: my_first
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


#Create a directory - 
directory '/var/tmp/generator' do
	owner 'vagrant'
	group 'vagrant'
	mode '755'
	action :create
end

#Installing httpd, python-pip, java sdk, and elasticsearch = 
package 'httpd'

package 'epel-release'

package 'python-pip'

package 'java-1.8.0-openjdk-devel'

template '/etc/yum.repos.d/elasticsearch.repo' do
        source 'elasticsearch.repo.erb'
end

package 'elasticsearch'


#Starting httpd and elasticsearch services
service 'httpd' do
	action [:enable, :start]
end

service 'elasticsearch' do
	action :enable
	action :start
end


template '/var/www/html/index.html' do
        source 'index.html.erb'
	mode '0755'
	owner 'vagrant'
	group 'vagrant'
end

template '/var/tmp/generator/populate_data.py' do
        source 'populate_data.py.erb'
	mode '0755'
	owner 'vagrant'
	group 'vagrant'
end


#Installing python modules - elasticsearch and request
execute 'install pip packages' do
	command 'pip install elasticsearch'
end

execute 'install pip packages' do
	command 'pip install requests'
end

cron 'python script' do
	hour '5'
	minute '0'
	command 'python /var/tmp/generator/populate_data.py'
end

#Running the pythpn script - 
#execute 'Run python script' do
#	command 'python /var/tmp/generator/populate_data.py'
#end
