RSpec.describe 'LineBotController', type: :request do
  describe 'POST /' do
    let(:user) { create(:user, :line_user, email: "line_test_#{SecureRandom.uuid}@example.com") }
    let(:headers) { { 'X-Line-Signature' => 'test_signature', 'CONTENT_TYPE' => 'application/json'  } }
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

    #
    let(:client) { instance_double(Line::Bot::Client, reply_message: true) }

    before do
      allow(Line::Bot::Client).to receive(:new).and_return(client)
      allow(client).to receive(:validate_signature).and_return(true)
      allow(client).to receive(:parse_events_from).and_return(events)
      allow(client).to receive(:reply_message).and_return(true)
    end

    fit 'responds with the food list message' do
      post '/', params: events.to_json, headers: headers

      expect(response).to have_http_status(:ok)

      puts "Client was called: #{client.inspect}"
      expect(client).to have_received(:reply_message).with(
        'test_token',
        { type: 'text', text: '食材が登録されていません。' }
      )
    end
    # 9/2 12;30 以下のエラーが発生
    # 予想問題点
    # have_received マッチャが正しく機能していない可能性。
    # テスト内でclientオブジェクトが何らかの理由で期待される呼び出しを認識していない可能性。
    #   1) LineBotController POST / responds with the food list message
    #  Failure/Error:
    #  expect(client).to have_received(:reply_message).with(
    #    'test_token',
    #    { type: 'text', text: '食材が登録されていません。' }
    #  )

    #  (InstanceDouble(Line::Bot::Client) (anonymous)).reply_message("test_token", {:text=>"食材が登録されていません。", :type=>"text"})
    #      expected: 1 time with arguments: ("test_token", {:text=>"食材が登録されていません。", :type=>"text"})
    #      received: 0 times
  end
end
