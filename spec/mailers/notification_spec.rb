require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:food_today) { create(:food, user: user, name: "にんじん", expiration_date: Date.today) }
  let(:food_tomorrow) { create(:food, user: user, name: "テスト食材2", expiration_date: Date.tomorrow) }
  let(:food_future) { create(:food, user: user, name: "テスト食材3", expiration_date: 2.days.from_now.to_date) }
  before do
    search_recipe_mock
  end
  describe "食材の消費期限の通知メールの送信" do
    context '消費期限日が2日前の食材が存在する場合' do
      let(:mail) { UserMailer.expiration_notice(user, food_today, '今日', []) }

      it '正しい送信先にメールが送られること' do
        expect(mail.to).to eq([user.email])
      end

      it 'メールの件名が正しいこと' do
        expect(mail.subject).to eq("#{food_today.name}の消費期限通知")
      end

      it 'メール本文に食材の名前が含まれていること' do
        expect(mail.body.encoded).to include(food_today.name)
      end

      it 'メール本文に消費期限が含まれていること' do
        expect(mail.body.encoded).to include('今日')
      end
    end

  end
end
