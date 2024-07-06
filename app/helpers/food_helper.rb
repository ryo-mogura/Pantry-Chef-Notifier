# frozen_string_literal: true

module FoodHelper
  def format_food_list(food_items)
    food_items.map do |food|
      "食材名: #{food.name}\n在庫数: #{food.quantity}\n消費期限: #{food.expiration_date}\n"
    end.join("\n")
  end

  def format_food_limits(limit_foods)
    limit_foods.map do |food|
      "食材名: #{food.name}\n消費期限: #{food.expiration_date}\n"
    end.join("\n")
  end

  def self.recipes_list(response, text)
    columns = response.map do |recipe|
      {
        thumbnailImageUrl: recipe['foodImageUrl'],
        title: recipe['recipeTitle'][0..39], # タイトルを40文字以内に
        text: recipe['recipeDescription'][0..59], # テキストを60文字以内に
        actions: [
          {
            type: 'uri',
            label: 'レシピを見る',
            uri: recipe['recipeUrl']
          }
        ]
      }
    end

    {
      type: 'template',
      altText: text || 'レシピ一覧',
      template: {
        type: 'carousel',
        columns: columns
      }
    }
  end
end
