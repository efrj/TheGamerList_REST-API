# == Route Map
#

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      # Authentication routes
      post 'auth/login', to: 'authentication#login'
      post 'auth/register', to: 'authentication#register'
      
      # User routes
      get 'users/me', to: 'users#me'
      put 'users/me', to: 'users#update'
      
      # Resource routes
      resources :softhouses
      resources :platforms_informations
      resources :platforms
      resources :genres
      resources :generations
      resources :games
      resources :contents
      resources :banners
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
