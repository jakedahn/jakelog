Jakelog::Application.routes.draw do
  get '/admin' => 'static#admin'
  get '/feed.atom' => 'posts#feed'


	match "/auth/:provider" => "sessions#new", :as => "login"
  match "/logout" => "sessions#destroy", :as => "logout"
  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"


  resources :posts
  put "/posts/:id" => "posts#update", as: "update_post"

  root :to => 'posts#index'
end
