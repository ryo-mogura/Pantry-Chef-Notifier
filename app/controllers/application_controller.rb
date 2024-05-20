# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    # 新規登録時にnameパラメーターを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # 編集時にnameパラメーターを許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
