class Init < ActiveRecord::Migration
  def self.up       
    create_table  "votes" do |t|
      t.string    "name", :null => false
    end

    create_table  "questions" do |t|
      t.string    "text", :null => false
      t.integer   "vote_id", :null => false
      t.integer   "count"
    end
  end

  def self.down
    drop_table "questions"
    drop_table "votes"
  end
end