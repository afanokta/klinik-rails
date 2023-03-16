Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :user
  resources :medical_history
  resources :schedule
  resources :appointment
  resources :department
  namespace 'user' do
  end
  get '/doctors', to: 'user#doctor'
  post '/login', to: 'user#login'
end
