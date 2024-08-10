require 'rails_helper'
describe 'FoodのCRUD' do
  let(:user) { create(:user) } # ユーザーを定義
  let!(:food) { create(:food, user: user, name: "テスト食材2",expiration_date: Date.today ) }
  let!(:food2) { create(:food, user: user, name: "テスト食材1", expiration_date: Date.today + 1 ) }
  let!(:food3) { create(:food, user: user, name: "テスト食材3", expiration_date: Date.today + 2) }
  let!(:food_with_image) { create(:food, user: user, name: "画像付きのテスト食材", expiration_date: Date.today + 2, ) }
  before do
    sign_in(user)
  end
  #----------------index------------------------
  describe '一覧表示' do
    context '食材が登録されている場合' do
      it '登録した食材が表示される' do
        expect(page).to have_content food.name
        expect(page).to have_content food.expiration_date
        expect(page).to have_content food.quantity
        expect(page).to have_content I18n.t("activerecord.attributes.food.storages.#{food.storage}")
      end
      it '画像が登録されていない場合' do

      end
      it '画像が登録されてる場合' do

      end
      it '詳細ページへ遷移できる' do
        click_on "詳細", match: :first
        expect(current_path).to eq food_path(food.id)
      end
    end

    context 'ソート機能' do
      it '期限が近い順にソートできる', js: true do
        select '消費期限が近い順', from: '並び替え'
        expect(page).to have_text(food.name)
        expect(page).to have_text(food2.name)
        expect(page).to have_text(food3.name)
        food_names = page.all('.card-title').map(&:text)
        expect(food_names).to eq([food.name, food2.name, food3.name])
      end
      it '期限が遠い順にソートできる', js: true do
        select '消費期限が遠い順', from: '並び替え'
        expect(page).to have_text(food.name)
        expect(page).to have_text(food2.name)
        expect(page).to have_text(food3.name)
        food_names = page.all('.card-title').map(&:text)
        expect(food_names).to eq([food3.name, food2.name, food.name])
      end
      it '名前順にソートできる', js: true do
        select 'あいうえお順', from: '並び替え'
        expect(page).to have_text(food.name)
        expect(page).to have_text(food2.name)
        expect(page).to have_text(food3.name)
        food_names = page.all('.card-title').map(&:text)
        expect(food_names).to eq([food2.name, food.name, food3.name])
      end
    end
  end

  #----------------new------------------------
  describe '新規食材の登録' do
    context 'フォームの入力値が正常な場合' do
      it '登録に成功する' do
        fill_in '食材名', with: 'テスト食材'
        fill_in '在庫数', with: 1
        fill_in '消費期限', with: Date.today
        click_on '登録する'
        expect(current_path).to eq(foods_path)
        expect(page).to have_text('テスト食材')
      end
    end

    context '食材名・在庫数・期限日のいずれかが入力されていない場合' do
      it '登録に失敗する' do
        fill_in '食材名', with: ''
        fill_in '在庫数', with: 1
        fill_in '消費期限', with: Date.today
        click_on '登録する'
        expect(current_path).to eq(new_food_path)
        expect(page).to have_text('食材を作成できませんでした')
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
