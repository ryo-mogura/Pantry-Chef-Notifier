RSpec.describe 'LineBotController', type: :request do
  fdescribe 'POST #callback' do
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

      # Line::Bot::Clientのインスタンスをスタブ化
      @client_instance = instance_double('Line::Bot::Client')
      allow(Line::Bot::Client).to receive(:new).and_return(@client_instance)

      # クライアントインスタンスのメソッドをスタブ
      allow(@client_instance).to receive(:validate_signature).and_return(true)
      allow(@client_instance).to receive(:parse_events_from).and_return([line_event])
      allow(@client_instance).to receive(:reply_message).and_return(nil)
    end

    context 'ユーザーが食材リストを送信したとき' do
      let(:line_event) do
        Line::Bot::Event::Message.new(
          'replyToken' => 'dummy_reply_token',
          'type' => 'message',
          'timestamp' => Time.now.to_i * 1000,
          'source' => { 'type' => 'user', 'userId' => line_user_id },
          'message' => { 'id' => '325708', 'type' => 'text', 'text' => message_text }
        )
      end
      it '食材リストを返信する' do
        post '/', params: '', headers: { 'HTTP_X_LINE_SIGNATURE' => signature }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
