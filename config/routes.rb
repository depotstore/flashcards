Rails.application.routes.draw do
  root 'static_pages#home'
  post 'static_pages/check_answer'
  # display 'home' form when browser reloaded
  get 'static_pages/check_answer', to: 'static_pages#home'
  resources :cards, except: [:show]
end
