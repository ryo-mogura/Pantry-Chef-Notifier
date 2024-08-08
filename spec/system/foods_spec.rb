require 'rails_helper'
describe 'FoodのCRUD' do
  let(:user) { FactoryBot.create(:user) }
  before do
    sign_in(user)
  end
  #----------------index------------------------
  describe '一覧表示' do
    context '食材が登録されている場合' do
      it '登録した食材が表示される' do
      end
      it '画像が登録されていない場合' do

      end
      it '画像が登録されてる場合' do

      end
      it '詳細ページへ遷移できる' do
      end
    end

    context 'ソート機能' do
      it '期限が近い順にソートできる' do
        select '消費期限が近い順', from: 'ソート順'
      end
      it '期限が遠い順にソートできる' do
        select '消費期限が遠い順', from: 'ソート順'
      end
      it '名前順にソートできる' do
        select 'あいうえお順', from: 'ソート順'
      end
    end
  end

  #----------------new------------------------
  describe '新規食材の登録' do
    context 'フォームの入力値が正常な場合' do
      it '登録に成功する' do

      end
    end

    context '食材名・在庫数・期限日が入力されていない場合' do
      it '登録に失敗する' do

      end
    end

    describe '画像の登録' do
      context '新規画像の登録をする場合' do
        it '登録に成功する' do

        end
      end
      context 'デフォルト画像を使用して登録する場合' do
        it '登録に成功する' do

        end
      end
      context '画像を登録しない場合' do
        it 'デフォルト画像が使用される' do

        end
      end
      context '新規画像の登録とデフォルト画像を使用して登録が選択されている場合' do
        it '登録に失敗する' do

        end
      end
    end
  end

  #----------------show------------------------
  describe '食材の詳細' do
    it '食材の情報が表示されている' do

    end
    it 'モーダルで編集画面が表示される' do

    end
    it '削除btnが表示されている' do

    end
    it '戻るbtnが表示されている' do

    end
  end
end
