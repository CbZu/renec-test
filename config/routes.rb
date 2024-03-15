Rails.application.routes.draw do

  get '/signup', to: "registrations#new"
  post '/signup', to: "registrations#create"

  post '/login', to: "sessions#login"
  delete '/logout', to: "sessions#logout"

  get '/videos-sharing', to: "videos_sharing#get"
  post '/videos-sharing', to: "videos_sharing#create"

  mount ActionCable.server => '/cable'
end
