# frozen_string_literal: true

module FoodHelper
  def format_food_list(food_items)
    header = "| 食材名 | 在庫数 | 消費期限 |\n|---|---|---|\n"
    rows = food_items.map do |food|
      "| #{food.name} | #{food.quantity} | #{food.expiration_date} |"
    end.join("\n")
    header + rows
  end

  def format_food_limits(limit_foods)
    header = "| 食材名 | 消費期限 |\n|---|---|\n"
    rows = limit_foods.map do |food|
      "| #{food.name} | #{food.expiration_date} |"
    end.join("\n")
    header + rows
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
