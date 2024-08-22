require 'rails_helper'

RSpec.describe "LineBot", type: :system do
  let(:line_user) { create(:user, uid: 1234567890, provider: 'line', email: 'line_user@example.com', ) }
  describe 'LineBot' do

  end
end
