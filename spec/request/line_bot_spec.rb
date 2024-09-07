RSpec.describe 'LineBotController', type: :request do
  fdescribe 'LineBot API' do
    let(:valid_signature) { 'valid-signature' }
    let(:user) { create(:user, uid: 'U1234567890', provider: 'line') }
    let(:food_item) { create(:food, user: user, name: 'りんご', expiration_date: Date.today) }

    before do
      allow_any_instance_of(Line::Bot::Client).to receive(:validate_signature).and_return(true)
      allow_any_instance_of(Line::Bot::Client).to receive(:reply_message).and_return(true)
    end

    describe 'POST /callback' do
      it '「食材リスト」を送信した際に正しいリストが返される' do
        post '/',
          params: line_request_with_text('食材リスト').to_json,
          headers: { 'X-Line-Signature' => valid_signature, 'Content-Type' => 'application/json' }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('食材名: りんご 在庫数: 3')
      end

      it '「食材リスト」を送信した際、食材が登録されていない場合に適切なメッセージが返されるか' do
        post '/',
          params: line_request_with_text('食材リスト').to_json,
          headers: { 'X-Line-Signature' => valid_signature, 'Content-Type' => 'application/json' }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('食材が登録されていません。')
      end
    end
  end
end
