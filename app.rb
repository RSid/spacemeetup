require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'
require_relative 'app/models/meetup'
require_relative 'app/models/user'
require_relative 'app/models/usermeetup'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @meetups = Meetup.all
  @my_meetups = UserMeetup.all
  binding.pry

  erb :index
end

post '/' do
  name = params['name']
  description = params['description']
  Meetup.create(name: name, description: description)

  redirect '/'
end

get '/meetup/:id' do
  @meetup = Meetup.find(params[:id])
  erb :meetup
end

post '/meetup/:id' do
  meetup_id = params[:id]
  binding.pry
  UserMeetup.create(user_id: session[:user_id], meetup_id: meetup_id)

  redirect '/'
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
