require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'erb'
require 'active_record'

environment = ENV['RACK_ENV']

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig[environment]

class Vote < ActiveRecord::Base
 has_many :questions

 def total_votes
  total = 0
  self.questions.each do |q|
    total += q.count
  end
  total
 end
end

class Question < ActiveRecord::Base
 belongs_to :vote

 def total_votes
  0
 end

 def vote_address
  "/do_vote/#{self.vote.id}/#{self.id}"
 end
end

class LunchVoteOMatic < Sinatra::Base

 get '/favicon.ico' do
 end

 get '/' do
  @count = 10
  erb :new
 end

 post '/' do
  @vote = Vote.new
  @vote.name = params[:name]
  if @vote.save
   questions = params[:question]
   questions.each do |number, text|
    new_question = Question.new
    new_question.text = text
    new_question.count = 0
    new_question.vote_id = @vote.id
    new_question.save unless text == ""
   end
   redirect "/#{@vote.id}"
  else
   redirect '/'
  end
 end

 get '/:id' do
  begin
    @vote = Vote.find(params[:id]) 
  
    if @vote.nil?
     redirect '/'
    else
     @vote.questions.sort! {|x,y| x.text <=> y.text }
     erb :show
    end
  
  rescue
    redirect '/'
  end
 end

 get '/do_vote/:vote_id/:question_id' do
  question = Question.find(params[:question_id])
  if question.nil?
   redirect "/#{params[:vote_id]}"
  else
   question.count = question.count.to_i + 1
   question.save
   redirect "/#{params[:vote_id]}"
   #"Votes: #{question.count.to_s}"
  end
 end

end
