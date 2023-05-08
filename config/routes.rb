Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'users#index'
  get '/user' => 'users#index', :as => :user_root
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :boards, only: %i[index show create update destroy] do
    resources :board_subscriptions, only: [:create]
    resources :stories, only: %i[index show create update destroy] do
      put 'assign', on: :member
      post 'next_column', on: :member
      post 'previous_column', on: :member
      resources :comments, only: %i[index show create update destroy]
    end
  end

  resources :columns, only: %i[index show create update destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
