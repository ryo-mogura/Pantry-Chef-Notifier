module SignInSupport
  def sign_in(user)
    visit unauthenticated_root_path
    within '.pc-screen' do
      click_on '新規登録 / ログイン'
    end
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    within '.session' do
      click_on 'ログイン'
    end
  end
end
