# frozen_string_literal: true

class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :line_messages, dependent: :destroy
  has_many :rakuten_recipes, dependent: :destroy

  enum status: { idle: 0,
                 waiting_for_recipe: 1,
                 waiting_add_food_name: 2,
                 waiting_add_food_quantity: 3,
                 waiting_add_food_expiration: 4,
                 waiting_add_food_storage: 5,
                 waiting_add_food_image: 6,
                 waiting_delete_food: 7,
                 waiting_delete_food_number: 8,
                 waiting_add_category: 9
                 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line google_oauth2]

  # Lineログイン機能アクション
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  # OmniAuthから取得した認証情報を使って、ユーザーのソーシャルプロファイルを更新
  # （LINEとGoogleで使えるように汎用化）
  def set_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']

    credentials = omniauth['credentials']
    info = omniauth['info']

    access_token = credentials['refresh_token']
    access_secret = credentials['secret']
    credentials = credentials.to_json
    name = info['name']
    self.email = info['email'] if email.blank?  # emailが未設定の場合にGoogleのemailを使用
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    save!
  end

  # Lineログインを判定
  def line_logged_in?
    provider == 'line'
  end

  # Googleログイン情報を基にユーザーを検索または作成
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #     user.name = auth.info.name   # Googleから取得した名前を使用
  #   end
  # end
end
