require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'pry'

require_relative 'config/application'
require_relative 'app/models/meetup'
require_relative 'app/models/user'
require_relative 'app/models/event'
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
  @meetups = Meetup.all.order(:name)
  if signed_in?
    @my_meetups = User.find(session[:user_id]).meetups

  end


  erb :index
end

post '/' do
  name = params['name']
  description = params['description']

  if signed_in?
    new_meetup = Meetup.create(name: name, description: description)
    flash[:notice] = "You have successfully created a meetup!"
  else
    authenticate!
  end

  redirect "/meetup/#{new_meetup.id}"
end

get '/meetup/:id' do

  @meetup = Meetup.find(params[:id])
  @events = @meetup.events
  @users = @meetup.users
  binding.pry
  erb :meetup
end

post '/meetup/join/:id' do
  meetup_id = params[:id]

  if signed_in?
    UserMeetup.create(user_id: session[:user_id], meetup_id: meetup_id)
    flash[:notice] = "You have successfully joined a meetup!"
  else
    authenticate!
  end

  redirect '/'
end

post '/meetup/leave/:id' do
  meetup_id = params[:id]

  if signed_in?
    UserMeetup.destroy_all(user_id: session[:user_id], meetup_id: meetup_id)
    flash[:notice] = "You have successfully left a meetup!"
  else
    authenticate!
  end

  redirect '/'
end

post '/meetup/event/:meetup_id' do
  location = params['location']
  date = params['date']
  description = params['description']
  meetup_id = params[:meetup_id]

  if signed_in?
    Event.create(location: location, date: date, description: description, meetup_id: meetup_id)
    flash[:notice] = "You have successfully created an event!"
  else
    authenticate!
  end

  redirect "/meetup/#{meetup_id}"

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
