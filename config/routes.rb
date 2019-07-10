Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :items
    resources :reviews, only: %i[new create destroy]
  resources :merchants
  resources :orders

  put '/cart', to: 'carts#remove_item'
  patch '/cart/decrease', to: 'carts#decrease_item'
  patch '/cart/increase', to: 'carts#increase_item'
  resource :cart, except: :put

  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'

  get "/items/:item_id/reviews/new", to: 'reviews#new'
  post "/items/:item_id/reviews", to: 'reviews#create'
  get '/items/:item_id/:review_id/edit', to: 'reviews#edit'
  patch '/items/:item_id/:review_id', to: 'reviews#update'
end
