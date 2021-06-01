Rails.application.routes.draw do
  root to: 'statics#root'
  get 'uploads/:text', to: 'statics#uploads'

  namespace :api do
    resources :menu_items
  end
end
