Rails.application.routes.draw do
  get 'uploads/*photo', to: 'uploads#show'

  namespace :api do
    resources :menu_items
  end
end
