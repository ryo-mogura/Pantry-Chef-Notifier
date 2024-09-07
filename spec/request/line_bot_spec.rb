RSpec.describe 'LineBotController', type: :request do
  describe 'LineBot API' do
    let(:valid_signature) { 'valid-signature' }
    let(:invalid_signature) { 'invalid-signature' }
    let(:user) { create(:user, uid: 'U1234567890', provider: 'line') }
    let(:food_item) { create(:food, user: user, name: 'りんご', quantity: 3) }
    let(:expiring_food) { create(:food, user: user, name: 'バナナ', expiration_date: Date.today + 1.day) }

    before do
      allow_any_instance_of(Line::Bot::Client).to receive(:validate_signature).and_return(true)
      allow_any_instance_of(Line::Bot::Client).to receive(:reply_message).and_return(true)
    end

    describe 'POST /' do

    end

    it '「食材リスト」を送信した際に正しいリストが返される' do

    end

    it '「食材リスト」を送信した際、食材が登録されていない場合に適切なメッセージが返されるか' do
      post '/', params: line_request_with_text('食材リスト').to_json, headers: { 'X-Line-Signature': valid_signature }, as: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('食材が登録されていません。')
    end
  end
end
