# frozen_string_literal: true

class RakutenRecipesController < ApplicationController
  def search
    @search = params[:keyword]

    if @search.present?
      category = RakutenWebService::Recipe.small_categories.find { |c| c.name.match(@search) }
      if category.nil?
        @recipes = []
        flash.now[:warning] = t('defaults.flash_message.not_searched')
      else
        @recipes = category.ranking
      end
    else
      flash.now[:warning] = t('defaults.flash_message.not_keyword')
    end
  end
# レシピを保存するアクションを追加
  def create
    @recipe = current_user.rakuten_recipes.new(recipe_params)

    if @recipe.save
      flash[:success] =  t('defaults.flash_message.keep')
      redirect_to users_profile_path
    else
      flash.now[warning] =  t('defaults.flash_message.not_keep')
      render :search
    end
  end

  def destroy
    @recipe = current_user.rakuten_recipes.find(params[:id])
    @recipe.destroy
    redirect_to users_profile_path, success: t('defaults.flash_message.delete_keep', item: RakutenRecipe.model_name.human), status: :see_other
  end

  private

  def recipe_params
    params.permit(:id, :title, :cost, :indication, :image_url, :recipe_url)

  end
end
