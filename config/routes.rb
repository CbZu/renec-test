Rails.application.routes.draw do

  post '/login', to: "sessions#login"

  get '/videos-sharing', to: "videos_sharing#get"
  post '/videos-sharing', to: "videos_sharing#create"

  mount ActionCable.server => '/cable'
end
