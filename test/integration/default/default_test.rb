# # encoding: utf-8

# Inspec test for recipe random_users::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


#httpd should be installed and running
describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_running }
end


#Elasticsearch should be installed and running
describe package('elasticsearch') do
  it { should be_installed }
end

describe service('elasticsearch') do
  it { should be_running }
end

#jdk 1.8. python-pip, and epel should be installed 
describe package('java-1.8.0-openjdk-devel') do
  it { should be_installed }
end

describe package('python-pip') do
  it { should be_installed }
end

describe package('epel-release') do
  it { should be_installed }
end

#Test to make sure python moduiles are installed - 
describe pip('elasticsearch') do
  it { should be_installed }
end

describe pip('requests') do
  it { should be_installed }
end

describe file('/var/www/html/index.html') do
	it {should exist}
	its ('mode') { should cmp 0755 }
	its ('owner') { should eq 'vagrant' }
	its ('group') { should eq 'vagrant' }
end

describe file('/var/tmp/generator/populate_data.py') do
	it {should exist}
	its ('mode') { should cmp 0755 }
	its ('owner') { should eq 'vagrant' }
	its ('group') { should eq 'vagrant' }
end

#Test to verify crontab entry
describe crontab do
	its ('commands') { should include 'python /var/tmp/generator/populate_data.py'}
	its('hours') { should cmp '5' }
  	its('minutes') { should cmp '0' }
end

