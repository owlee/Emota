Rails.application.routes.draw do
  resources :emota do
    collection do
      get 'detected_faces'
      get 'undetected_faces'
    end
  end
  resources :homes
  root 'home#index'
end
