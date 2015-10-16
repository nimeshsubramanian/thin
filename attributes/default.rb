# coding: UTF-8
# Cookbook Name::thin
# attribute:: default

default['thin'].tap do |thin|
  thin['app']['gem']['ignore_group'] = ''
  thin['app_name'] = ''
  thin['user'] = 'thin'
  thin['group'] = 'thin'
  thin['base_dir'] = '/opt'
  thin['run_dir'] = '/var/run'
  thin['etc_dir'] = '/etc/thin'
  thin['log_dir'] = '/var/log'
  thin['ruby_version'] = '2.1.2'
  thin['log']['name'] = 'thin.log'
  thin['config']['address'] = '0.0.0.0'
  thin['config']['port'] = '80'
  thin['config']['require'] = [ ]
  thin['config']['timeout'] = '10'
  thin['config']['wait'] = '10'
  thin['config']['max_conns'] = '1024'
  thin['config']['environment'] = 'development'
  thin['config']['max_persistent_conns'] = '124'
  thin['config']['servers'] = '1'
  thin['config']['threaded'] = 'true'
  thin['config']['daemonize'] = 'true'
  thin['config']['no-epoll'] = 'true'

  thin['gems']['install']['thin'] = { version: ['~> 1.6'] }
  thin['gems']['install']['bundler'] = { version: ['~> 1.10'] }
end
