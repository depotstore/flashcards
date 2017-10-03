Rails.application.routes.draw do
  root 'static_pages#home'
  resources :cards, except: [:show]
end
