Rails.application.routes.draw do
  resources :emota
  resources :homes
  root 'home#index'
end
