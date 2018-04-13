require 'sinatra'
require "sinatra/reloader" if development?
require "pry" if development? || test?
require_relative 'config/application'
require_relative 'app/models/party.rb'
also_reload 'apps/models/party.rb'
require 'pry'

enable :sessions

set :bind, '0.0.0.0'  # bind to all interfaces

get '/' do
  redirect '/parties'
end

get '/parties' do
  @parties = Party.all
  erb :'parties/index'
end
#Add party page
get '/party/new' do
  erb :'parties/new'
end
#Add Party
post "/new" do
  name = params["name"]
  location = params["location"]
  description=params["description"]
  @error_name = name
  @error_location = location
  @error_description = description
  if name == "" || location == "" || description == ""
    @error = "Please complete all fields."
    erb :'parties/new'
  else
  newParty = Party.create(name: name,location: location, description: description)
  flash[:notice] = "You have created a party. Good for me."
  redirect to "/parties/#{newParty.id}"
  end
end
#Specific Party
get '/parties/:id' do
  # binding.pry
  id = params[:id]
  @id = id
  invite_id = id
  @party = Party.find(id)
  @invites = Party.find(invite_id).invite_lists
  @friendlist = Friend.all
  erb :'parties/show'
end
#Delete a party
delete '/parties/:id' do
  @party_object = Party.delete(params[:id])
  flash[:notice] = "You have deleted a party. Bad you. >:("
  redirect to "/"
  erb :'parties/show'
end

#All Friends
get '/friends' do
  unordered_friends = Friend.all
  @friends = unordered_friends.order(:first_name)
  erb :'friends/index'
end

#Adding friend
post "/parties/:id" do
  partyid = params["id"]
  friendid=params["invite_friend"]
  addedFriend = InviteList.create(party_id:partyid,friend_id:friendid)
  flash[:notice] = "You have added a friend :). Good for me."
  redirect to "/parties/#{partyid}"
end

#Add friend page
get '/friend/new' do
  erb :'friends/new'
end
#Adding friend to friendlist
post "/newfriend" do
  binding.pry
  first_name = params["first_name"]
  last_name = params["last_name"]
  @error_first_name = first_name
  @error_last_name = last_name
  if first_name == "" || last_name == ""
    @error = "Please complete all fields."
    erb :'friends/new'
  else
  newFriend = Friend.create(first_name: first_name,last_name: last_name)
  flash[:notice] = "You have made another friend :). Good for me."
  redirect to "/friends"
  end
end
#Delete Invite from InviteList
delete '/invite/:id' do
  @partyID = InviteList.find(params[:id]).party_id
  @party_object = InviteList.delete(params[:id])
  flash[:notice] = "You have deleted a friend. Bad you. >:("
  redirect to "/parties/#{@partyID}"
  erb :'parties/show'
end
