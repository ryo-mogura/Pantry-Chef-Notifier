RSpec.describe 'LineBotController', type: :request do
  fdescribe 'LineBot API' do
    let(:line_user_id) { 'U1234567890abcdef1234567890abcdef' }
    let(:user) { create(:user, uid: line_user_id) }
    let!(:food) { create(:food, user: user, name: 'りんご', expiration_date: Date.today) }
    let(:message_text) { '食材リスト' }
    let(:signature) { 'test_signature' }
    let(:line_channel_secret) { 'test_channel_secret' }
    let(:line_channel_token) { 'test_channel_token' }

    before do
      # LINE Messaging APIの認証情報をテスト用に差し替え
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('LINE_CHANNEL_SECRET').and_return(line_channel_secret)
      allow(ENV).to receive(:[]).with('LINE_CHANNEL_TOKEN').and_return(line_channel_token)

      # Line::Bot::Clientのインスタンスをモック化
      @client_instance = instance_double('Line::Bot::Client')
      allow(Line::Bot::Client).to receive(:new).and_return(@client_instance)

      # クライアントインスタンスのメソッドをスタブ化
      allow(@client_instance).to receive(:validate_signature).and_return(true)
      allow(@client_instance).to receive(:parse_events_from).and_return([line_event])
      allow(@client_instance).to receive(:reply_message).and_return(nil)
    end

    it '食材リストを返信する' do
      post '/', params: '', headers: { 'HTTP_X_LINE_SIGNATURE' => signature }

      expect(response).to have_http_status(:ok)
      expected_text = "食材名: りんご\n在庫数: #{food.quantity}\n消費期限: #{food.expiration_date}\n"
      expected_message = { type: 'text', text: expected_text }
      expect(@client_instance).to have_received(:reply_message).with('dummy_reply_token', expected_message)
    end
  end
end
