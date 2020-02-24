Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
  	get "follow" => "relationships#follow"
  	get "follower" => "relationships#follower"
  end
  resources :relationships,only: [:create, :destroy]
  resources :books do
     resource :book_comment ,only: [:create, :destroy]
     resource :favorite ,only: [:create, :destroy]
  end
  root to: "home#top"
  get 'home/about'
end
