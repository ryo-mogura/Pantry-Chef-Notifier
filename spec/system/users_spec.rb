require 'rails_helper'
describe 'UserのCRUD' do
  let(:user) { create(:user) }

  #----------------registration new------------------------
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

  #----------------sessions------------------------
  describe 'ログイン' do
    before do
      visit new_user_session_path
    end

    it '正しい情報でログインすると、ユーザーがログインされること' do
      fill_in 'Email', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).to have_content('ログインしました。')
      expect(current_path).to eq(authenticated_root_path)
    end

    it '誤った情報でログインすると、エラーメッセージが表示されること' do
      fill_in 'Email', with: 'wrong_email@example.com'
      fill_in 'パスワード', with: 'wrong_password'
      click_button 'ログイン'

      expect(page).to have_content('Eメールまたはパスワードが違います。')
    end
  end

  #------------------passward----------------------
  describe 'パスワードを忘れた場合に再設定のメールを送る処理' do
    before do
      visit new_user_password_path
    end

    it '登録されているメールアドレスにパスワードリセットメールが送信されること' do
      fill_in '登録メールアドレスを入力', with: user.email
      click_button '再設定メールを送信する'

      expect(page).to have_content('パスワードの再設定について数分以内にメールでご連絡いたします。')
      expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
      expect(ActionMailer::Base.deliveries.last.subject).to eq('パスワードの再設定について')
    end

    it '登録されていないメールアドレスにはパスワードリセットメールが送信されないこと' do
      fill_in '登録メールアドレスを入力', with: 'nonexistent@example.com'
      click_button '再設定メールを送信する'

      expect(page).to have_content('Eメールは見つかりませんでした。')
      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end
end
