namespace :db do

    require 'active_record'
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true  


  task :environment do
   # ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :dbfile =>  'db/test.db'
    ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))['production']) 
  end

  desc "Deploy to Heroku."
  task :deploy do
    require 'heroku'
    require 'heroku/command'
    
    user, pass = File.reader(File.expand_path("~/.heroku/credentials")).split("\n")
    heroku = Heroku::Client.new(user, pass)

    cmd = Heroku::Command::BaseWithApp.new([])
    remotes = cmd.git_remotes(File.dirname(__FILE__) + "/../..")

    remote, app = remotes.detect { |key, value| value == (ENV['APP'] || cmd.app) }

    if remote.nil?
     raise "Could not find a git remote for the '#{ENV['APP']}' app"
    end

    `git push #{remote} master`

    heroku.restart(app)
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
