Rails.application.routes.draw do
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  get '/home', to: 'home#index'
  get '/welcome/:first_name', to: 'welcome#hello'

  root 'static#index'

  resources :gossips do
  	resources :likes
  end
  resources :users
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]

end
