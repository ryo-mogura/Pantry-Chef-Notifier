Rails.application.config.middleware.use OmniAuth::Builder do
  # OmniAuthでの認証時にPOSTメソッドを許可する記述
  OmniAuth.config.allowed_request_methods = [:post, :get]
end
