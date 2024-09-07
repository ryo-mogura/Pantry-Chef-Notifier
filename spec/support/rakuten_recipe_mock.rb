module RakutenRecipeMock
  def search_recipe_mock
    allow(RakutenWebService::Recipe).to receive(:small_categories).and_return([
      OpenStruct.new(
        name: 'にんじん',
        ranking: [
          OpenStruct.new(title: 'レシピ1', foodImageUrl: 'https://example.com/recipe1.jpg', recipeTitle: 'レシピ1タイトル'),
          OpenStruct.new(title: 'レシピ2', foodImageUrl: 'https://example.com/recipe2.jpg', recipeTitle: 'レシピ2タイトル')
        ]
      )
    ])
  end
end
