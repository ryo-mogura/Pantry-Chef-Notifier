# frozen_string_literal: true

module Users
  class ProfilesController < ApplicationController
    def show
      @user = current_user
      @recipes = @user.rakuten_recipes
    end

    private

    def current_user_params
      params.require(:user).permit(:name, :email)
    end
  end
end
