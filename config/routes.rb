Rails.application.routes.draw do
  root 'static_pages#home'
  post 'static_pages/check_answer'
   # displays 'home' form when browser reloaded
  get 'static_pages/check_answer', to: 'static_pages#home' #code debt
  resources :cards, except: %i[show]
end
