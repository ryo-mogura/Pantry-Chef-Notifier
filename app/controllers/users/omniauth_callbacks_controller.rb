# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def line
      login_action
    end

    private

    def login_action
      @omniauth = request.env['omniauth.auth'] # OmniAuthから取得した認証情報を含むハッシュ
      if @omniauth.present?
        @profile = User.find_or_initialize_by(provider: @omniauth['provider'], uid: @omniauth['uid']) # 取得した認証情報のproviderとuidと一致するユーザーの検索
        # 検索したユーザーおよび初期化したユーザーのemailが空か確認
        if @profile.email.blank?
          # @omniauth["info"]["email"]が存在する場合、その値をemailに設定.
          # 存在しない場合、uidとproviderを使って一時的なメールアドレスを生成
          email = @omniauth['info']['email'] || "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
          # current_userが存在する場合、そのユーザーを@profileに設定
          # current_userが存在しない場合、新しいユーザーを作成し、そのユーザーを@profileに設定
          # User.create!メソッドは、指定された属性を持つ新しいユーザーを作成します。このとき、ランダムなパスワードを生成して設定
          @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email:, name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
        end
        @profile.set_values(@omniauth)
        sign_in(:user, @profile)
      end
      flash[:notice] = 'ログインしました'
      redirect_to root_path
    end

    def fake_email(_uid, _provider)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
  end
end
