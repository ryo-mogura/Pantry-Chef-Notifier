# frozen_string_literal: true

module FoodHelper
  def food_list(response, text)
    {
      type: 'flex',
      altText: text,
      contents: {
        type: 'bubble',
        header: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'text',
              text:,
              wrap: true,
              size: 'lg',
              align: 'center'
            }
          ]
        },
        body: {
          type: 'box',
          layout: 'horizontal',
          contents: [
            {
              type: 'text',
              text: response,
              wrap: true,
              size: 'sm'
            }
          ]
        }
      }
    }
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
