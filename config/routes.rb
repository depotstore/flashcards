Rails.application.routes.draw do
  root 'static_pages#home'
  post 'static_pages/check_answer'
  get 'static_pages/check_answer', to: 'static_pages#home' # display 'home' form when browser reloaded
  resources :cards, except: [:show]
end
