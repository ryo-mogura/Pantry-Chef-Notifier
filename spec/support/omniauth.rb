OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(
  provider: 'line',
  uid: 'test12',
  info: { email: 'test@example.com', name: 'test_user' },
  credentials: { token: 'test1212' }
)
