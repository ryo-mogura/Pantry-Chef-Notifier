class RakutenRecipesController < ApplicationController
  def search
    @categories = RakutenWebService::Recipe.medium_categories
    @search = params[:keyword]
    if @search.present?
      @filtered_categories = @categories.select { |category| category.name.include?(@search) }

      @recipes = @categories.first.ranking

    end
  end
end

# カテゴリー一覧APIでカテゴリーを取得
