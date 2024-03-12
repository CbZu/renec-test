Rails.application.routes.draw do

  get '/signup', to: "registrations#new"
  post '/signup', to: "registrations#create"

  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/videos-sharing', to: "videos_sharing#get"
  post '/videos-sharing', to: "videos_sharing#share"

  mount ActionCable.server => '/cable'
end
