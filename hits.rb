require "rubygems"
require "sinatra"
require "erb"

set :public, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/views'
set :haml, :attr_wrapper => '"'

URL  = "http://localhost:9393/"
load "models.rb"

get "/" do
  redirect "/#{Model.random}"
end

get "/api" do
  erb :api, :locals => {:human_name => 'API', :name => 'API', :title => 'API'}
end

get "/contest" do
  erb :contest, :locals => {:human_name => 'Contest', :name => 'Contest', :title => 'Contest'}
end

get "/:name" do
  #raise Sinatra::NotFound if !Model.exists? params[:name] || params[:name] == "api"
  tux = Model.new(params[:name])
  number = tux.get_count
  erb :index, :locals => {:clicks => number, :human_name => tux.human_name, :name => params[:name], :title => "Hit the #{tux.human_name}!"}
end

get "/:name/hit" do
  #raise Sinatra::NotFound if !Model.exists? params[:name] || params[:name] == "api"
  tux = Model.new(params[:name])
  number = tux.increment
  
  if request.xhr?
    number.to_s
  else
    redirect "/" + params[:name], 303
  end
  
end

not_found do
  erb :"404", :layout => :layout, :locals => {:human_name => '404', :name => '404'}
end