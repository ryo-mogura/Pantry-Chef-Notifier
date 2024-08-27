require 'rails_helper'
describe 'RakutenRecipesController' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit search_rakuten_recipes_path
  end
  
  describe 'レシピ検索' do
    before do
      # small_categoriesのモックを設定
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

    context '検索ワードが入力されている場合' do
      it '検索結果が表示される' do
        fill_in 'keyword', with: 'にんじん'
        click_on '検索する'
        expect(page).to have_content('レシピ1')
        expect(page).to have_content('レシピ2')
      end
    end

    context '検索ワードが入力されていない場合' do
      it '検索ワードを入力してくださいと表示される' do

      end
    end

    context '検索結果が存在しない場合' do
      it '検索結果がありませんと表示される' do
        fill_in 'keyword', with: 'カレー'
        click_on '検索する'
        expect(page).to have_content('検索結果がありません')
      end
    end
  end

  describe 'レシピのお気に入り登録' do
    context 'レシピが保存された場合' do
      it 'レシピを保存しましたと表示される' do

      end
      it 'マイページにお気に入りしたレシピが表示されている' do

      end
    end

    context 'お気に入りしたレシピを削除する場合' do
      it 'レシピを削除しましたと表示される' do

      end
      it 'マイページからお気に入りしたレシピが削除されている' do

      end
    end
  end
end
