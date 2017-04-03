Rails.application.routes.draw do
  resources :emota, only: [:index] do
    collection do
      get 'detected_faces'
      get 'undetected_faces'
      get 'last_n_faces'
      get 'latest'
    end
  end

  resources :conversations, only: [:index, :show]

  resources :homes, only: [:index]

  root 'home#index'
end
