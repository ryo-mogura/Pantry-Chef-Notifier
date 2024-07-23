class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_homes_top_path
  end
end
