Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  # セッション------------------------
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 管理者------------------------------
  namespace :admin do
    # ダッシュボード
    root to: 'dashboard#index'
    # ユーザ
    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    # タスク
    resources :tasks, only: [:index]
    # ラベル
    resources :labels, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # ユーザ-----------------------------------------
  resources :users, only: [:index, :create, :update, :destroy]
  get    'signup',    to: 'users#new'
  # (優先度最後)
  get    'settings/profile', to: 'users#edit', as: 'user_profile_edit'
  get    ':username', to: 'users#show', as: 'user_profile'
end
