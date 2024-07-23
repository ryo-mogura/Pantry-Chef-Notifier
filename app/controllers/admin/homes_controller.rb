class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :destroy]

  def top
    @users = User.all
  end

  def show
    @foods = @user.foods
  end

  def destroy
    @user.destroy
    redirect_to admin_root_path, success: t('defaults.flash_message.deleted', item: User.model_name.human), status: :see_other
  end

  def destroy_food
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to admin_home_path(@food.user_id), success: t('defaults.flash_message.deleted', item: Food.model_name.human), status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
