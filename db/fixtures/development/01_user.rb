# frozen_string_literal: true

User.seed do |s|
  s.id    = 1
  s.email = 'aaaa@email.com'
  s.password = 'test12'
  s.name = 'テストユーザー1'
end

User.seed do |s|
  s.id    = 2
  s.uid = '1234567890'
  s.provider = 'line'
  s.email = 'line_user@example.com'
  s.password = 'test34'
  s.name = 'LineUser'
end
