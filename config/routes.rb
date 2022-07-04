Rails.application.routes.draw do
  get 'comments/create'
  resources :stories do
    resources :comments
  end
  patch 'story/:id/for_review', to: 'stories#for_review', as: 'story_for_review'
  patch 'story/:id/in_review',  to: 'stories#in_review',  as: 'story_in_review'
  patch 'story/:id/pending',    to: 'stories#pending',    as: 'story_pending'
  patch 'story/:id/approved',   to: 'stories#approved',   as: 'story_approved'
  patch 'story/:id/published',  to: 'stories#published',  as: 'story_published'
  patch 'story/:id/archived',   to: 'stories#archived',   as: 'story_archived'

  resources :stories

  root 'stories#index'

  get 'home/index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
end
