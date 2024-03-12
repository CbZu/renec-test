Rails.application.routes.draw do

  get '/signup', to: "registrations#new"
  post '/signup', to: "registrations#create"

  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

end
