# coding: UTF-8

require 'rspec/core/rake_task'

# Integration tests. Kitchen.ci
require 'kitchen'
require 'kitchen/cli'

require 'rubocop/rake_task'
require 'foodcritic'

desc 'Run Ruby style checks'
task :rubocop do
  RuboCop::RakeTask.new
end

desc 'Run Chef style checks'
task :foodcritic do
  FoodCritic::Rake::LintTask.new do |t|
    t.options = {
      fail_tags: ['any']
    }
  end
end

desc 'Run style checks'
task style_check: ['foodcritic','rubocop']

desc 'Run ChefSpec'
RSpec::Core::RakeTask.new(:unit_test)

desc 'Run Test Kitchen'
task :kitchen do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

desc 'Run ChefSpec and ServerSpec'
task test: ['unit_test', 'kitchen']

task default: ['kitchen']
