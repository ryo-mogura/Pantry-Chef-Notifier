# frozen_string_literal: true

class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def new
    @food = current_user.foods.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save!
      flash[:notice] = '登録しました'
      redirect_to foods_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def destroy; end

  private

  def food_params
    params.require(:food).permit(:id, :name, :quantity, :expiration_date, :storage)
  end
end
