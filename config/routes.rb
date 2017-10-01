Rails.application.routes.draw do
  root 'static_pages#home'
  get 'static_pages/home'
  resources :cards, only: [:index, :show]
end
