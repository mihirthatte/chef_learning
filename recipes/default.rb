#
# Cookbook:: my_first
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


directory '/var/tmp/generator' do
	owner 'root'
	group 'root'
	mode '0776'
	action :create
end

package 'httpd'

package 'epel-release'

package 'python-pip'


service 'httpd' do
	action [:enable, :start]
end

template '/etc/yum.repos.d/elasticsearch.repo' do
	source 'elasticsearch.repo.erb'
end

package 'java-1.8.0-openjdk-devel'

package 'elasticsearch'
	
service 'elasticsearch' do
	action :enable
	action :start
end


template '/var/www/html/index.html' do
        source 'index.html.erb'
end

template '/var/tmp/generator/populate_data.py' do
        source 'populate_data.py.erb'
end

execute 'install pip packages' do
  command 'pip install elasticsearch'
end

execute 'install pip packages' do
  command 'pip install requests'
end


#execute 'create es index' do
#	command 'curl -X PUT "localhost:9200/test_es" -H "Content-Type: application/json" -d\' { "settings": { "number_of_shards": 1, "number_of_replicas": 0 }, "mappings": { "examplecase": { "properties": { "first_name": { "type": "text" }, "date_of_birth": { "type": "text" }, "last_name": { "type": "text" }, "location": { "type": "text" }, "email": { "type": "text" } } } } }\''
#end

