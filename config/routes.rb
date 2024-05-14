# frozen_string_literal: true

Rails.application.routes.draw do
  # Topページ
  root to: 'tops#top'
  # ユーザー認証
  devise_for :users
end
