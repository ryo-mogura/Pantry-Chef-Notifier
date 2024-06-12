# frozen_string_literal: true

class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index]

  def index
    @foods = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def new
    @food = current_user.foods.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      redirect_to foods_path, success: t('defaults.flash_message.created', item: Food.model_name.human)
    else
      flash.now[:warning] = t('defaults.flash_message.not_created', item: Food.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @food = Food.find(params[:id])
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    @food.update(food_params)

    if @food.save
      redirect_to foods_path, success: t('defaults.flash_message.edit', item: Food.model_name.human)
    else
      flash.now[:warning] = t('defaults.flash_message.not_edit', item: Food.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, success: t('defaults.flash_message.deleted', item: Food.model_name.human), status: :see_other
  end

  private

  def food_params
    params.require(:food).permit(:id, :name, :quantity, :expiration_date, :storage)
  end

  def set_q
    @q = current_user.foods.ransack(params[:q])
  end
end
