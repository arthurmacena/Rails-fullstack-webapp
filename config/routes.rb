Rails.application.routes.draw do
  resources :stories
  root 'stories#index'
  get 'home/index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
end
