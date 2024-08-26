require 'rails_helper'
describe 'RakutenRecipesController' do
  describe 'レシピ検索' do
    context '検索ワードが入力されている場合' do
      it '検索結果が表示される' do

      end
    end

    context '検索ワードが入力されていない場合' do
      it '検索ワードを入力してくださいと表示される' do

      end
    end

    context '検索結果が存在しない場合' do
      it '検索結果がありませんと表示される' do

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
