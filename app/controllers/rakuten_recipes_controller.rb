class RakutenRecipesController < ApplicationController
  def search
    @categories = RakutenWebService::Recipe.small_categories
    @search = params[:keyword]

    if @search.present?
      category = RakutenWebService::Recipe.small_categories.find { |c| c.name.match(@search) }
      if category.nil?
        @recipes = []
        flash.now[:warning] = t('defaults.flash_message.not_searched')
      else
        @recipes = category.ranking
      end
    end
  end
end
