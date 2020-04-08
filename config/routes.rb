Rails.application.routes.draw do

  get 'pages/show'
  post 'movies/add_to_cart/:id', to: 'movies#add_to_cart', as: 'add_to_cart'
  delete 'movies/remove_from_cart/:id', to: 'movies#remove_from_cart', as: 'remove_from_cart'

  root to: 'movies#index'
  resources 'movies', only: %i[index show]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get ':permalink', to: 'pages#show', as: 'show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
