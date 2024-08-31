RSpec.describe 'LineBotController', type: :request do
  describe 'POST /' do
    let(:user) { create(:user, :line_user) }
    let(:headers) { { 'X-Line-Signature' => 'test_signature' } }
    let(:events) do
      [
        {
          'type' => 'message',
          'replyToken' => 'test_token',
          'source' => {
            'userId' => user.uid
          },
          'message' => {
            'type' => 'text',
            'text' => '食材リスト'
          }
        }
      ]
    end

    let(:client) { instance_double(Line::Bot::Client) }

    before do
      allow(Line::Bot::Client).to receive(:new).and_return(client)
      allow(client).to receive(:validate_signature).and_return(true)
      allow(client).to receive(:parse_events_from).and_return(events) # ここでparse_events_fromをモック
      allow(client).to receive(:reply_message).and_return(true)
    end

    fit 'responds with the food list message' do
      post '/', params: events.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      expect(client).to have_received(:reply_message).with(
        'test_token',
        { type: 'text', text: '食材が登録されていません。' }
      )
    end
  end
end
