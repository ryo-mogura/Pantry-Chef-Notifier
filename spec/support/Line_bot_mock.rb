module LineBotSupport
  def line_request_with_text(text)
    {
      'events' => [
        {
          'type' => 'message',
          'replyToken' => 'dummy-reply-token',
          'source' => { 'userId' => user.uid },
          'message' => { 'type' => 'text', 'text' => text }
        }
      ]
    }
  end

  def line_request_with_non_text_message
    {
      'events' => [
        {
          'type' => 'message',
          'replyToken' => 'dummy-reply-token',
          'source' => { 'userId' => user.uid },
          'message' => { 'type' => 'image', 'id' => 'image-id' }
        }
      ]
    }
  end

  def multiple_line_events_request
    {
      'events' => [
        {
          'type' => 'message',
          'replyToken' => 'reply-token-1',
          'source' => { 'userId' => user.uid },
          'message' => { 'type' => 'text', 'text' => '食材リスト' }
        },
        {
          'type' => 'message',
          'replyToken' => 'reply-token-2',
          'source' => { 'userId' => user.uid },
          'message' => { 'type' => 'text', 'text' => '消費期限' }
        }
      ]
    }
  end

  def invalid_line_event_request
    {
      'events' => []
    }
  end
end


