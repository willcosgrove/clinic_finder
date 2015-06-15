Rails.application.routes.draw do
  resources :clinics, only: [:index]
end
