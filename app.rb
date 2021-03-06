require 'sinatra/base'
require './lib/peep'
require './database_connection_setup'
require './lib/user'

class Chitter < Sinatra::Base

  enable :sessions

  get '/' do
    'Chitter!'
  end

  get '/peeps' do
    @user = User.find(session[:user_id])

    @peeps = Peep.all
    erb :'peeps/index'
  end

  get '/peeps/new' do
    erb :"peeps/new"
  end

   post '/peeps' do
     Peep.create(pmessage: params[:pmessage])
     redirect '/peeps'
   end

   get '/users/new' do
     erb :"users/new"
   end

   post '/users' do
     User.create(username: params[:username], password: params[:password])
     redirect '/peeps'
   end

   get '/sessions/new' do
     erb :"sessions/new"
   end

   post '/sessions' do
     user = User.authenticate(username: params[:username], password: params[:password])

     if user
     session[:user_id] = user.id
     redirect('/peeps')
   else
     flash[:notice] = 'Please check your username or password.'
     redirect('/sessions/new')
   end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect['/peeps']
  end

  run! if app_file == $0
end
