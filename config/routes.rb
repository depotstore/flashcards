Rails.application.routes.draw do
  resources :user_sessions, only: %i[create]
  resources :users, except: %i[new index destroy]
  get 'register', to: 'users#new'
  get 'login', to: 'user_sessions#new'
  post 'logout', to: 'user_sessions#destroy'

  root 'static_pages#home'
  post 'static_pages/check_answer'
   # displays 'home' form when browser reloaded
  get 'static_pages/check_answer', to: 'static_pages#home' #code debt
  resources :cards, except: %i[show]
end
