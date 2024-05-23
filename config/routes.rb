# frozen_string_literal: true

Rails.application.routes.draw do
  # Topページ
  root to: 'tops#top'

  # ユーザー認証関係
  # ゲストユーザー機能でControllerをカスタマイズしているので変更
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    line_omniauth_callbacks: 'line_omniauth_callbacks'
  }
  devise_scope :user do
    # sign_inとsign_outのルーティングを変更する
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'signout', to: 'devise/sessions#destroy'
    # ゲストユーザーのログイン
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  namespace :users do
    resource :profile, only: [:show]
  end
end
