# coding: UTF-8
# Cookbook Name::thin
# recipe:: default

# Creating thin user
user node['thin']['user']

# Creating thin group
group  node['thin']['group'] do
  members node['thin']['user']
end

# Creating Directories for thin
[node['thin']['base_dir'], node['thin']['log_dir'], node['thin']['run_dir'], node['thin']['etc_dir']].each do |dir|
  directory dir do
    owner node['thin']['user']
    group node['thin']['group']
    mode '755'
  end
end

%w{gcc gcc-c++ autoconf automake openssl-devel readline-devel zlib-devel git}.each do |pkg|
  package pkg
end

# Installing ruby
include_recipe 'ruby_build'

ruby_build_ruby node['thin']['ruby_version']

ruby_path = "#{node[:ruby_build][:default_ruby_base_path]}/#{node['thin']['ruby_version']}"

# Intalling gems
node['thin']['gems']['install'].each do |key, value|
  gem_package key do
    action :install
    version value[:version]
    gem_binary "#{ruby_path}/bin/gem"
  end
end

error = ''

error << "#{node['thin']['app_name']} is empty" unless node['thin']['app_name']

raise error unless error.empty? 

unless node['thin']['local_development']
  # Fetching source
  git 'Fetching the App' do
    user node['thin']['user']
    repository node['thin']['git']['repository']
    if node['thin']['environment'] == 'development'
      checkout_branch node['thin']['git']['branch']
      enable_checkout false
    else
      revision node['thin']['git']['version']
    end
    destination "#{node['thin']['base_dir']}/#{node['thin']['app_name']}"
    notifies :run, 'execute[App dependencies]', :immediately
    action :sync
  end
end

# Installing App gem dependencies
execute 'App dependencies' do
  group node['thin']['group']
  cwd "#{node['thin']['base_dir']}/#{node['thin']['app_name']}"
  if node['thin']['app']['gem']['ignore_group'].empty?
    command "#{ruby_path}/bin/bundle install"
  else
    command "#{ruby_path}/bin/bundle install --without #{node['thin']['app']['gem']['ignore_group']}"
  end
  unless node['thin']['local_development']
    action :nothing
  else
    action :run
  end
end

# Generating sane values for the config.yml for thin
node.default['thin']['config']['chdir'] =  "#{node['thin']['base_dir']}/#{node['thin']['app_name']}"
node.default['thin']['config']['tag'] = node['thin']['app_name']
node.default['thin']['config']['socket'] = "#{node['thin']['run_dir']}/#{node['thin']['app_name']}.sock"
node.default['thin']['config']['log'] = "#{node['thin']['log_dir']}/#{node['thin']['log']['name']}"

thin_config_path = "#{node['thin']['etc_dir']}/config.yml"

# Thin config
template 'Thin config' do 
  source 'config.yml.erb'
  path thin_config_path
  owner node['thin']['config']['user']
  group node['thin']['config']['group']
  mode '750'
  action :create
  notifies :restart, 'service[thin]'
end

# Sets Thin up as a service
include_recipe 'runit'

runit_service 'thin' do
  default_logger true
  options( app_dir: node['thin']['config']['chdir'],
    ruby_bin: "#{ruby_path}/bin",
    config_file: thin_config_path
    )
  notifies :start, 'service[thin]'
end

# Thin service
service 'thin' do 
  action :nothing
end
