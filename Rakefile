
task :environment do
  require 'active_record'
  require 'logger'
  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))['production']) 
  #ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :dbfile =>  'db/test.sqlite3'
end

namespace :db do
  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
end
