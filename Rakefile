namespace :db do

    require 'active_record'
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true  


  task :environment do
   # ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :dbfile =>  'db/test.db'
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))["development"]) 
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
