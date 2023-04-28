Rails.application.routes.draw do
  root 'users#index'
  get '/user' => "users#index", :as => :user_root
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :boards, only: [:index, :show, :create, :update, :destroy] do
    resources :board_subscriptions, only: [:create]
    resources :stories, only: [:index, :show, :create, :update, :destroy] do
      post 'assign', on: :member
      resources :comments, only: [:index, :show, :create, :update, :destroy]
    end
  end
  
  resources :columns, only: [:index, :show, :create, :update, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
