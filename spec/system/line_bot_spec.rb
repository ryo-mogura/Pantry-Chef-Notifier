require 'rails_helper'

RSpec.describe "LineBot", type: :system do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
    visit new_user_session_path
    click_on 'Lineログイン'
    expect(current_path).to eq authenticated_root_path
    expect(page).to have_content('ログインしました')
  end

  fdescribe 'LineBot' do
    describe '食材の登録機能' do
      context '画像付きで登録する場合' do
        it '登録に成功する' do

        end
        it '登録に失敗する' do

        end
      end
      context '画像なしで登録する場合' do
        it '登録に成功する' do

        end
      end
    end
    describe '食材の削除機能' do
      it '食材の削除に成功する' do

      end
      it '食材の削除に失敗する' do

      end
    end
    describe '食材のリスト取得機能' do
      context '食材が登録されている場合' do
        it '食材のリストの取得に成功する' do

        end
      end
      context '食材が登録されていない場合' do
        it '食材が登録されていない場合' do

        end
      end
    end
    describe '消費期限が二日以内の食材の情報を取得' do
      context '消費期限が二日以内の食材が登録されている場合' do
        it '消費期限が当日の食材の情報を取得する' do

        end
        it '消費期限が翌日の食材の情報を取得する' do

        end
        it '消費期限が明後日の食材の情報を取得する' do

        end
      end
      context '消費期限が二日以内の食材が登録されていない場合' do
        it '二日以内が期限の食材はありません。と表示される' do

        end
      end

    end
    describe 'レシピ検索機能' do
      it 'レシピ検索に成功する' do

      end
      it 'レシピ検索に失敗する' do

      end
    end
  end
end