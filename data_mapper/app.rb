require 'bundler'
Bundler.require
#require_relative './lib/rabbit.rb'

Dir.glob('./lib/*rb') do |model|
  require model
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/rabbits.db")

get '/rabbits' do
  @rabbits = Rabbit.all
  haml :index
end

get '/rabbits/new' do
  @rabbit = Rabbit.new
  haml :new
end

#create rabbit
post '/rabbits' do 
  @rabbit = Rabbit.new(params[:rabbit])
  if @rabbit.save
    status 201
    redirect '/rabbits/' + @rabbit.id.to_s
  else
    status 404
    haml :new
  end
end

#edit rabbit
get '/rabbits/edit/:id' do 
  @rabbit = Rabbit.get(params[:id])
  haml :edit
end

#update rabbit
put '/rabbits/:id' do 
  @rabbit = Rabbit.get(params[:id])
  if @rabbit.update(params[:rabbit])
    status 201
    redirect '/rabbits/' + params[:id]
  else
    status 400
    haml :edit
  end
end

#delete rabbit confirmation
get '/rabbits/delete/:id' do 
  @rabbit = Rabbit.get(params[:id])
  haml :delete
end

#delete rabbit
delete '/rabbits/:id' do 
  Rabbit.get(params[:id]).destroy
  redirect '/rabbits'
end

#show rabbit
get '/rabbits/:id' do 
  @rabbit = Rabbit.get(params[:id])
  haml :show
end


DataMapper.auto_upgrade!