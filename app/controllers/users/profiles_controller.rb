class Users::ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  private

  def current_user_params
    params.require(:user).permit(:name, :email)
  end
end
