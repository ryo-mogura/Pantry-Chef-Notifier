# frozen_string_literal: true

module Users
  class ProfilesController < ApplicationController
    def show
      @foods = current_user.foods
      @limit_expiration = current_user.foods.where(expiration_date: Date.today..2.days.from_now.to_date)
      @over_expiration = current_user.foods.where('expiration_date < ?', Date.today)

      
      @recipes = current_user.rakuten_recipes
      categories = Category.all
      @category_data = categories.map do |category|
        [category.name, current_user.foods.where(category_id: category.id).count]
      end
    end

    private

    def current_user_params
      params.require(:user).permit(:name, :email)
    end
  end
end
