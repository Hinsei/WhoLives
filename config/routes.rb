Rails.application.routes.draw do
  root "welcome#index"

  resources :users

  get "users/new" => "users#new", as: "sign_up"
  get "session/new" => "session#new", as: "log_in"

  post "session/new" => "session#create", as: "logging_in"
  delete "session/destroy" => "session#destroy", as: "log_out"

end
