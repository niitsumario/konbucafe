Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'
  resources :posts, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  get "post/ranks" => "posts#ranks", as: 'ranks'
  resources :users, only: [:show, :edit, :update] do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  get "users/:id/likes" => "users#likes", as: 'likes'
end
