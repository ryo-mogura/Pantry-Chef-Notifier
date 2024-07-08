# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  # OmniAuthでの認証時にPOSTメソッドを許可する記述
  OmniAuth.config.allowed_request_methods = %i[post get]
end
