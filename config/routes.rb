Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :items do
    resource :favorites, only: [:create, :destroy]

    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :uptate] do
    resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
  end

end
