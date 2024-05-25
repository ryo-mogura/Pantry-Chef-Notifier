# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    before_action :ensure_normal_user, only: :create

    # ゲストユーザーのパスワード再設定をできないようにするアクション
    def ensure_normal_user
      redirect_to new_user_session_path, alert: 'ゲストユーザーのパスワード再設定はできません。' if params[:user][:email].downcase == 'guest@example.com'
    end
  end
end
