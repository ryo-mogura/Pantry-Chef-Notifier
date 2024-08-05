# frozen_string_literal: true

Rails.application.routes.draw do
  # Topページ
  authenticated :user do
    root to: 'foods#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'tops#top', as: :unauthenticated_root
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get '/' => 'homes#top', as: :root
    resources :homes, only: [:show, :destroy]
    delete 'destroy_food/:id', to: 'homes#destroy_food', as: 'destroy_food'
  end

  # ゲストユーザー機能でControllerをカスタマイズしているので変更
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    # sign_inとsign_outのルーティングを変更する
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'signout', to: 'devise/sessions#destroy'
  end

  # LineBot
  post '/', to: 'line_bot#callback'
  namespace :users do
    resource :profile, only: [:show]
  end

  resources :foods

  # rakuten
  # get 'search', to: 'rakuten_recipes#search'
  resources :rakuten_recipes, only: [:create, :destroy] do
    collection do
      get 'search'
    end
  end

  # policy_pages
  get '/policy', to: 'tops#privacy_policy', as: :privacy_policy

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?


end
