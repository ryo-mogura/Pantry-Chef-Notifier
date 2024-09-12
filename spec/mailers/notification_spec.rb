require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:food_today) { create(:food, user: user, name: "テスト食材1", expiration_date: Date.today) }
  let(:food_tomorrow) { create(:food, user: user, name: "テスト食材2", expiration_date: Date.tomorrow) }
  let(:food_future) { create(:food, user: user, name: "テスト食材3", expiration_date: 2.days.from_now.to_date) }

  let(:food_carrot) { create(:food, user: user, name: "にんじん", expiration_date: Date.today) }
  let(:food_onion) { create(:food, user: user, name: "たまねぎ", expiration_date: Date.today) }

  let(:expiration_notice) do
    case food_today.expiration_date
    when Date.today
      '今日'
    when Date.tomorrow
      '明日'
    else
      food_today.expiration_date.strftime('%m月%d日')
    end
  end

  let(:recipes) { RakutenWebService::Recipe.small_categories.find { |c| c.name.match(food_carrot.name) }.ranking }
  before do
    search_recipe_mock
  end
  describe "食材の消費期限の通知メールの送信" do
    context '消費期限日が当日の食材が存在する場合' do
      let(:mail) { UserMailer.expiration_notice(user, food_today, expiration_notice , []) }
      it '正しいメール内容が送られること' do
        expect(mail.to).to eq([user.email])  # 送信先の確認
        expect(mail.subject).to eq("#{food_today.name}の消費期限通知")  # 件名の確認
        expect(mail.body.encoded).to include(food_today.name)  # メール本文に食材名が含まれているか
        expect(mail.body.encoded).to include('今日')  # メール本文に消費期限が含まれているか
      end
    end
    context '消費期限日が明日の食材が存在する場合' do
      let(:mail) { UserMailer.expiration_notice(user, food_tomorrow, expiration_notice , []) }
      it '正しいメール内容が送られること' do
        expect(mail.to).to eq([user.email])  # 送信先の確認
        expect(mail.subject).to eq("#{food_tomorrow.name}の消費期限通知")  # 件名の確認
        expect(mail.body.encoded).to include(food_tomorrow.name)  # メール本文に食材名が含まれているか
        expect(mail.body.encoded).to include('今日')  # メール本文に消費期限が含まれているか
      end
    end
    context 'レシピが存在している場合' do
      let(:mail) { UserMailer.expiration_notice(user, food_today, expiration_notice, recipes) }
      it 'メール本文にレシピが含まれていること' do
        expect(mail.body.encoded).to include(food_today.name)
        expect(mail.body.encoded).to include('レシピ1タイトル')
        expect(mail.body.encoded).to include('レシピ2タイトル')
        expect(mail.body.encoded).to include('https://example.com/recipe1.jpg')
        expect(mail.body.encoded).to include('レシピを見る')
      end
    end
    context 'レシピが存在しない場合' do
      let(:recipes) do
        RakutenWebService::Recipe.small_categories.find { |c| c.name.match(food_onion.name) }&.ranking || []
      end
      let(:mail) { UserMailer.expiration_notice(user, food_onion, expiration_notice, recipes)}
      it 'メール本文にレシピが含まれていないこと' do
        expect(mail.body.encoded).to include(food_onion.name)
        expect(mail.body.encoded).not_to include('レシピ1タイトル')
        expect(mail.body.encoded).not_to include('レシピ2タイトル')
        expect(mail.body.encoded).to include('関連するレシピが見つかりませんでした。')
      end
    end
  end
end
