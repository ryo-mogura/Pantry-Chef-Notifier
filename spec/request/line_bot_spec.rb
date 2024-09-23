RSpec.describe 'LineBotController', type: :request do
  fdescribe 'LineBot API' do
    let(:line_user_id) { 'U1234567890abcdef1234567890abcdef' }
    let(:user) { create(:user, uid: line_user_id) }
    let!(:food) { create(:food, user: user, name: 'りんご', expiration_date: Date.today) }
    let(:message_text) { '食材リスト' }
    let(:signature) { 'test_signature' }
    let(:line_channel_secret) { 'test_channel_secret' }
    let(:line_channel_token) { 'test_channel_token' }
  end
end
