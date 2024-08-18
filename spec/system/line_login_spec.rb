require 'rails_helper'

RSpec.describe "omniauth", type: :system do

  describe 'LineLoginの処理' do
    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
    end
    context 'lineログインを押した場合' do
      it 'ログインができる' do
        visit new_user_session_path
        click_on 'Lineログイン'
        expect(current_path).to eq authenticated_root_path
        expect(page).to have_content('ログインしました')
      end
    end
  end
end
