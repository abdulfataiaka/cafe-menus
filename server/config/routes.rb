Rails.application.routes.draw do
  root to: 'statics#root'
  get 'favicon.ico',   to: 'statics#client'
  get 'static/*text',  to: 'statics#client'
  get 'uploads/*text', to: 'statics#uploads'

  namespace :api do
    resources :menu_items
  end
end
