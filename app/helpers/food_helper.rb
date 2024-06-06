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
end
