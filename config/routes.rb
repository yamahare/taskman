Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  # セッション
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # ユーザ
  resources :users, only: [:index, :create, :show, :edit, :update, :destroy]
  get    'signup', to: 'users#new'

  namespace :admin do
    # ダッシュボード
    root to: 'dashboard#index'
    # ユーザ
    resources :users, only: [:index, :create, :show, :edit, :update, :destroy]
  end
end
