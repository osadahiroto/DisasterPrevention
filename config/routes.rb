Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :items do
    resources :comments, only: [:create, :destroy]
  end
  
end
