Rails.application.routes.draw do

  get 'orders/index'
  get 'orders/show'

  get 'pages/show'
  post 'movies/add_to_cart/:id', to: 'movies#add_to_cart', as: 'add_to_cart'
  post 'movies/increase_quantity/:id', to: 'movies#increase_quantity', as: 'increase_quantity'
  post 'movies/decrease_quantity/:id', to: 'movies#decrease_quantity', as: 'decrease_quantity'
  delete 'movies/remove_from_cart/:id', to: 'movies#remove_from_cart', as: 'remove_from_cart'

  scope 'checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create' # CAN USE :id PARAMS FOR THIS
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  root to: 'movies#index'
  resources 'movies', only: %i[index show]

  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get ':permalink', to: 'pages#show', as: 'show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
