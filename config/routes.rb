Rails.application.routes.draw do
  resources :emota, only: [:index] do
    collection do
      get 'detected_faces'
      get 'undetected_faces'
    end
  end

  resources :conversations, only: [:index]

  resources :homes, only: [:index]

  root 'home#index'
end
