Rails.application.routes.draw do
  resources :messages
  resources :matches
  resources :likes
  resources :sun_signs
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
