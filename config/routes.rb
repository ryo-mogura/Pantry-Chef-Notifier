# frozen_string_literal: true

Rails.application.routes.draw do
  # Topページ
  authenticated :user do
    root to: 'foods#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'tops#top', as: :unauthenticated_root
  end

  # ユーザー認証関係
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
    # ゲストユーザーのログイン
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # LineBot
  post '/', to: 'line_bot#callback'
  namespace :users do
    resource :profile, only: [:show]
  end

  resources :foods

  # rakuten
  get 'search', to: 'rakuten_recipes#search'
end
