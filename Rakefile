

task :environment do
  require 'active_record'
  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))['production']) 
end

namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
