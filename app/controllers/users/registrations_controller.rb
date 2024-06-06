# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :ensure_normal_user, only: %i[update destroy]
    # ゲストユーザーの編集・削除をできないようにするアクション
    def ensure_normal_user
      redirect_to authenticated_root_path, alert: 'ゲストユーザーの更新・削除はできません' if resource.email == 'guest@example.com'
    end
  end
end
