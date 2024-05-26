# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :provider, :string # 認証プロバイダーの名前を保存(Lineログインだとlineが登録)
    add_column :users, :uid, :string # 認証プロバイダーから提供されたユーザーの一意識別子（ユーザーID）を保存するためのカラム
  end
end
