require 'rails_helper'
describe 'FoodのCRUD' do
  let(:user) { create(:user) } # ユーザーを定義
  let!(:food) { create(:food, user: user, name: "テスト食材2", expiration_date: Date.today ) }
  let!(:food2) { create(:food, user: user, name: "テスト食材1", expiration_date: Date.today + 1 ) }
  let!(:food3) { create(:food, user: user, name: "テスト食材3", expiration_date: Date.today + 2) }
  let!(:image) { create(:image) }
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
        expect(food.food_image.url).to eq('nophoto.png')
        expect(page).to have_content I18n.t("activerecord.attributes.food.storages.#{food.storage}")
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
    before do
      visit new_food_path
    end
    context 'フォームの入力値が正常な場合' do
      it '登録に成功する' do
        fill_in '食材名', with: 'テスト食材'
        fill_in '在庫数', with: 1
        fill_in 'food[expiration_date]', with: Date.today
        click_on '登録する'
        expect(current_path).to eq(foods_path)
        expect(page).to have_text('テスト食材')
      end
    end

    context '食材名・在庫数・期限日のいずれかが入力されていない場合' do
      it '登録に失敗する' do
        fill_in '食材名', with: ''
        fill_in '在庫数', with: 1
        fill_in 'food[expiration_date]', with: Date.today
        click_on '登録する'
        expect(current_path).to eq(new_food_path)
        expect(page).to have_text('食材を作成できませんでした')
      end
    end

    describe '画像の登録' do
      context '新規画像の登録をする場合' do
        it '登録に成功する' do
          fill_in '食材名', with: 'テスト食材'
          fill_in '在庫数', with: 1
          fill_in 'food[expiration_date]', with: Date.today
          attach_file 'food[food_image]', Rails.root.join('spec/fixtures/images/test.jpg')
          click_on '登録する'
          expect(page).to have_text('食材を作成しました')
          food = Food.last
          expect(food.name).to eq('テスト食材')
          expect(food.food_image.url).to end_with('test.jpg')
        end
      end
      context '初期データの画像を使用して登録する場合' do
        it '登録に成功する' do
          fill_in '食材名', with: 'テスト食材'
          fill_in '在庫数', with: 1
          fill_in 'food[expiration_date]', with: Date.today
          select 'テスト初期データ画像', from: 'food[image_id]'
          click_on '登録する'
          expect(current_path).to eq(foods_path)
          expect(page).to have_text('食材を作成しました')
        end
      end
      context '画像を登録しない場合' do
        it 'デフォルト画像が使用される' do
          fill_in '食材名', with: 'テスト食材'
          fill_in '在庫数', with: 1
          fill_in 'food[expiration_date]', with: Date.today
          click_on '登録する'
          expect(current_path).to eq(foods_path)
          food = Food.last
          expect(food.name).to eq('テスト食材')
          expect(food.food_image.url).to eq('nophoto.png')
        end
      end
      context '新規画像の登録とデフォルト画像を使用して登録が選択されている場合' do
        it '登録に失敗する' do
          fill_in '食材名', with: 'テスト食材'
          fill_in '在庫数', with: 1
          fill_in 'food[expiration_date]', with: Date.today
          attach_file 'food[food_image]', Rails.root.join('spec/fixtures/images/test.jpg')
          select 'テスト初期データ画像', from: 'food[image_id]'
          click_on '登録する'
          expect(current_path).to eq(new_food_path)
          expect(page).to have_text('画像は1枚だけ選択してください')
        end
      end
    end
  end

  #----------------show------------------------
  describe '食材の詳細' do
    before do
      click_on '詳細', match: :first
      visit food_path(food.id)
    end
    it '食材の情報が表示されている' do
      expect(page).to have_text (food.name)
      expect(page).to have_text (food.expiration_date.strftime('%Y年%m月%d日'))
      expect(page).to have_field('input-number', with: food.quantity)
    end
    it '削除btnが表示されている' do
      expect(page).to have_link '使いきった'
    end
  end
  #----------------edit------------------------
  describe '食材の編集', js:true do
    before do
      click_on '詳細', match: :first
      visit food_path(food.id)
    end
    context '名前を編集する場合' do
      it '編集に成功する' do
        click_on food.name
        fill_in '食材名を入力', with: '編集後食材'
        click_on '変更する'
        expect(page).to have_text '編集後食材'
      end
    end
    context '在庫数を編集する場合' do
      it '編集に成功する' do
        fill_in 'input-number', with: 5
        expect(find('#input-number').value).to eq('5')
      end
    end
    context '期限日を編集する場合' do
      it '編集に成功する' do
        click_on food.expiration_date.strftime('%Y年%m月%d日')
        fill_in 'food[expiration_date]', with: Date.today + 1
        click_on '変更する'
        expect(page).to have_text((Date.today + 1).strftime('%Y年%m月%d日'))
      end
    end
    context '画像を編集する場合' do
      it '新規の画像を登録して編集に成功する' do
        find('.image-card').click
        attach_file 'food[food_image]', Rails.root.join('spec/fixtures/images/test.jpg')
        click_on '変更する'
      end
      it '初期データの画像を使用して編集に成功する' do
        find('.image-card').click
        select 'テスト初期データ画像', from: 'food[image_id]'
        click_on '変更する'
        expect(page).to have_selector("img[src='#{image.image_url.url}']")
        binding.irb
      end
    end
    context '保存場所を編集する場合' do
      it '編集に成功する' do
        click_on I18n.t("activerecord.attributes.food.storages.#{food.storage}")
        select '冷凍庫', from: 'food_storage'
        expect(page).to have_text '冷凍庫'
      end
    end
  end
  #----------------delete------------------------
  describe '食材の削除' do
    before do
      click_on '詳細', match: :first
      visit food_path(food.id)
    end
    it '削除に成功する' do
      click_on '使いきった'
      expect(current_path).to eq(foods_path)
      expect(page).to have_text('食材を削除しました')
      expect(page).not_to have_text(food.name)
    end
  end
end
