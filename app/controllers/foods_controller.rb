# frozen_string_literal: true

class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index]

  def index
    @foods = @q.result(distinct: true).page(params[:page]).per(12)
  end

  def new
    @food = current_user.foods.new
    @categories = Category.all
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.image_id.present? && @food.food_image.present?
      redirect_to new_food_path, warning: t('defaults.flash_message.double_image', item: Food.model_name.human)
    elsif @food.save
      redirect_to foods_path, success: t('defaults.flash_message.created', item: Food.model_name.human)
    else
      redirect_to new_food_path, warning: t('defaults.flash_message.not_created', item: Food.model_name.human)
    end
  end

  def show
    @food = Food.find(params[:id])
    @categories = Category.all
  end

  def edit
    @food = Food.find(params[:id])
    @categories = Category.all
  end

  def update
    food = Food.find(params[:id])
    @categories = Category.all
    # image_idが存在していて、food_imageを新しく設定する場合
    if food.image_id.present? && food_params[:food_image].present?
      food.image_id = nil
    end
    # food_imageが存在していて、image_idを新しく設定する場合
    if food.food_image.present? && food_params[:image_id].present?
      food.food_image = nil
    end

    food.update(food_params)

    if food.image_id.present? && food.food_image.present?
      redirect_to food_path(food), warning: t('defaults.flash_message.double_image', item: Food.model_name.human)
    elsif food.save
      redirect_to food_path(food)
    else
      @food = food
      redirect_to food_path(food), warning: t('defaults.flash_message.not_edit', item: Food.model_name.human)
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, success: t('defaults.flash_message.deleted', item: Food.model_name.human), status: :see_other
  end

  private

  def food_params
    params.require(:food).permit(:id, :name, :quantity, :expiration_date, :storage, :food_image, :food_image_cache, :category_id, :image_id)
  end

  def set_q
    @q = current_user.foods.ransack(params[:q])
  end
end
