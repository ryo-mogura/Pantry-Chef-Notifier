# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # ゲストユーザーのログインアクション
    def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to authenticated_root_path, notice: 'ゲストユーザーとしてログインしました。'
    end
  end
end
