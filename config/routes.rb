Jakelog::Application.routes.draw do
  resources :posts
  put "/posts/:id" => "posts#update", as: "update_post"

  root :to => 'posts#index'
end
