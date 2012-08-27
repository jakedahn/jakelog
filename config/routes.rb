Jakelog::Application.routes.draw do
  get "static/index"

  get '/admin' => 'static#admin'

	match "/auth/:provider" => "sessions#new", :as => "login"
  match "/logout" => "sessions#destroy", :as => "logout"
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"

  resources :posts
  put "/posts/:id" => "posts#update", as: "update_post"

  root :to => 'posts#index'
end
