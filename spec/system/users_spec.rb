require 'rails_helper'
describe 'UserのCRUD' do
  let(:user) { create(:user) }

  before do

  end

  #----------------registration new------------------------
  describe '新規登録' do
    describe '新規登録' do
      before do
        visit new_user_registration_path
      end
      it '新しいユーザーを作成することができること' do
        fill_in 'ユーザー名', with: 'テストユーザー'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'

        expect(page).to have_content('アカウント登録が完了しました。')
        expect(User.last.name).to eq('テストユーザー')
        expect(User.last.email).to eq('test@example.com')
      end

      it '必要な情報が入力されていない場合、エラーメッセージが表示されること' do
        click_button '登録する'

        expect(page).to have_content('Eメールが入力されていません')
        expect(page).to have_content('パスワードが入力されていません')
      end

      it 'パスワードとパスワード確認が一致しない場合、エラーメッセージが表示されること' do
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'different_password'
        click_button '登録する'

        expect(page).to have_content('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end

  #----------------sessions------------------------
end
