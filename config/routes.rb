Squashladder::Application.routes.draw do

  root :to => "users#index"

  match "/welcome" => "welcome#index"
  match "/login" => "welcome#login"
  match "/logout" => "welcome#logout"

  match "/user/:id" => "users#show", :via => [:get]
  match "/user/:id" => "users#update", :via => [:put]
  match "/user/:id/recent_matches" => "users#recent_matches"
  match "/user/:id/all_matches" => "users#all_matches"

  resources :availabilities

  # match "/availabilities/:user_id" => "availabilities#index", :via => [:get]
  # match "/availability/:user_id" => "availabilities#create", :via => [:post]
  # match "/availability/:id" => "availabilities#update", :via => [:put]
  # match "/availability/:id" => "availabilities#destroy", :via => [:delete]

  match "/match" => "matches#create", :via => [:post]
  match "/match/:id/dispute" => "matches#dispute", :via => [:post]
  match "/match/:id/confirm" => "matches#confirm", :via => [:post]


end
