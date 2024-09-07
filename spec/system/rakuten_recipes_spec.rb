require 'rails_helper'
describe 'RakutenRecipesController' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    search_recipe_mock
    visit search_rakuten_recipes_path
  end

  describe 'レシピ検索' do
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
        fill_in 'keyword', with: ''
        click_on '検索する'
        expect(page).to have_content('検索ワードを入力してください')
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
      it 'レシピを保存しましたと表示され、マイページにお気に入りしたレシピが表示されている' do
        fill_in 'keyword', with: 'にんじん'
        click_on '検索する'
        click_on 'お気に入りに追加', match: :first
        expect(current_path).to eq(users_profile_path)
        expect(page).to have_content('レシピを保存しました')
        expect(page).to have_content('レシピ1')
      end
    end

    context 'お気に入りしたレシピを削除する場合' do
      before do
        fill_in 'keyword', with: 'にんじん'
        click_on '検索する'
        click_on 'お気に入りに追加', match: :first
        expect(current_path).to eq(users_profile_path)
      end

      it 'レシピを削除しましたと表示され、' do
        click_on '削除', match: :first
        expect(page).to have_content('レシピを削除しました')
        expect(page).not_to have_content('レシピ1')
      end
    end
  end
end
