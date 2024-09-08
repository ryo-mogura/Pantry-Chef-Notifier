# PantryChefNotifier(- 食材管理とレシピ提示アプリ -)
## サービスURL
https://pantry-chef-notifier.com
## サービス概要
消費・賞味期限が近い食材と、その食材を使用したレシピを通知してくれるアプリです。
## Webアプリを開発するに至った経緯
一人暮らしをしている中で、以下の問題に直面したことがありました。
- 以前購入した食材を忘れ、同じ食材を再び購入してしまうことが度々ありました。その結果、冷蔵庫や冷凍庫が不要な食材で溢れかえり管理が難しくなりました。
- 購入した食材の消費期限を把握しきれず期限を過ぎてしまい、廃棄せざるを得ないことが多くありました。これにより無駄な出費が増え、食材の無駄遣いが続いていました。
- 冷凍庫に保存していた魚や肉類が、いつ保存したものか分からなくなることが頻繁にありました。そのため、食材の鮮度や品質が不明なまま使用することになり、安全にも不安が生じていました。
- 消費期限が近い食材を使って料理をする際に、適したレシピを探すのが面倒に感じることもありました。毎回レシピを探す手間が増え、料理をするモチベーションが低下することもありました。

これらの問題を解決し、食材の管理を効率化するために、消費期限の管理やレシピの検索を容易にするWebアプリを開発するに至りました。
## 想定されるユーザー層
- 一人暮らしをしている人
- 忙しい毎日を過ごしている人
- 冷蔵庫の管理・料理をしている人
## サービスの利用イメージ
レスポンシブ対応を実装することでスマホ、PC どちらからでも使うことができます。

ユーザーは食材を登録することで冷蔵庫の中身を可視化することができます。
また冷蔵庫を確認しなくてもLine通知によって食材の消費・賞味期限を把握することができます。
## ユーザーの獲得について
- Xを用いた宣伝
- Qiitaの開発記事による宣伝
## サービスの差別化ポイント・推しポイント
食材の管理を行えるアプリは多数ありますが、ほとんどの方が使用しているLineを使用して食材の数量や消費期限、レシピ検索の操作を行える点が差別化ポイントになると考えています。
また、Lineとの対話形式で食材の登録および削除を行えるため、簡単に食材の管理ができるようになっています。
## 機能一覧
トップ画面 | ログイン画面
-- | --
[![Image from Gyazo](https://i.gyazo.com/e7e1ae987f47a09b7c2ac2a2a178383d.jpg)](https://gyazo.com/e7e1ae987f47a09b7c2ac2a2a178383d)| [![Image from Gyazo](https://i.gyazo.com/7c500d3532ebab7a5f13823abb468b01.png)](https://gyazo.com/7c500d3532ebab7a5f13823abb468b01)

食材一覧画面 | 食材の登録画面
-- | --
[![Image from Gyazo](https://i.gyazo.com/abb364ef28956fdee46c6a3f0c28c5b7.gif)](https://gyazo.com/abb364ef28956fdee46c6a3f0c28c5b7) | [![Image from Gyazo](https://i.gyazo.com/b32b0a97c20d4d78bfa5ca9dc27676bb.gif)](https://gyazo.com/b32b0a97c20d4d78bfa5ca9dc27676bb)

食材の詳細 | 食材の編集（詳細ページ上）
-- | --
[![Image from Gyazo](https://i.gyazo.com/00e2d772675ec4d623273f1f35a286ab.gif)](https://gyazo.com/00e2d772675ec4d623273f1f35a286ab) | [![Image from Gyazo](https://i.gyazo.com/4a7c16674d30850c2a306e838516fe84.gif)](https://gyazo.com/4a7c16674d30850c2a306e838516fe84)

食材の削除機能 | レシピ検索ページ
-- | --
[![Image from Gyazo](https://i.gyazo.com/1bb8c722ee31fe1b302e00e868cd7611.gif)](https://gyazo.com/1bb8c722ee31fe1b302e00e868cd7611) | [![Image from Gyazo](https://i.gyazo.com/4f348ca4689a5c47c835ba401b4bf551.gif)](https://gyazo.com/4f348ca4689a5c47c835ba401b4bf551)

## Line上の機能一覧
メニュー画面 | 食材の登録 | 食材の登録(2)
-- | -- | --
[![Image from Gyazo](https://i.gyazo.com/44cf3c1113087d9ab7eb4ed257df9d35.png)](https://gyazo.com/44cf3c1113087d9ab7eb4ed257df9d35) | [![Image from Gyazo](https://i.gyazo.com/460fb0b78f668b791b7e14cd4073b9f9.png)](https://gyazo.com/460fb0b78f668b791b7e14cd4073b9f9) | [![Image from Gyazo](https://i.gyazo.com/ff5f91d4cd7be3a1f8e1aef27cceec6f.png)](https://gyazo.com/ff5f91d4cd7be3a1f8e1aef27cceec6f)

食材の登録(3) | 食材リスト | 消費期限が2日以内の食材の取得
-- | -- | --
[![Image from Gyazo](https://i.gyazo.com/776ecd6d0e5b65525fe02247362dc5a9.png)](https://gyazo.com/776ecd6d0e5b65525fe02247362dc5a9) | [![Image from Gyazo](https://i.gyazo.com/a59a2a7ec3af97292a230c4e2da69eeb.png)](https://gyazo.com/a59a2a7ec3af97292a230c4e2da69eeb) | [![Image from Gyazo](https://i.gyazo.com/25062e2fec3eff88bde3daae9fecf1a9.png)](https://gyazo.com/25062e2fec3eff88bde3daae9fecf1a9)

食材の削除 | レシピ検索 | 入力情報のリセット
-- | -- | --
[![Image from Gyazo](https://i.gyazo.com/00e57e02c47a045e52ba2865f54794e1.png)](https://gyazo.com/00e57e02c47a045e52ba2865f54794e1) | [![Image from Gyazo](https://i.gyazo.com/48802a38ff45551edd25e31146753e41.png)](https://gyazo.com/48802a38ff45551edd25e31146753e41) | [![Image from Gyazo](https://i.gyazo.com/403e60d59930e221f2683e214e3aaa6a.jpg)](https://gyazo.com/403e60d59930e221f2683e214e3aaa6a)

### MVP
- ユーザー登録
  - メール・パスワード
  - Lineログイン
- アカウント
  - プロフィール
- 食材リスト
  - 登録
  - 編集（詳細ページで行う）
  - 削除
  - ソート (消費期限順、名前順)
- Line通知(AM:8:00に通知が来るように設定)
  - 消費期限が２日以内の食材のリスト
  - 消費期限が２日以内の食材を使用したレシピ
- LineBotとの対話機能
  - 食材リストの取得
  - 消費期限リストの取得
  - レシピ検索
### 本リリース
- 食材のカテゴリー機能
- LineBotとの対話機能
  - 食材の登録
  - 食材の削除
- レシピのお気に入り機能
- メール通知(AM:8:00に通知が来るように設定)
  - 消費期限が２日以内の食材のリスト
  - 消費期限が２日以内の食材を使用したレシピ
- 管理者機能
## 技術スタック
### 以下予定している技術スタックです
| カテゴリー | 技術スタック |
| ---- | ---- |
| Frontend | Rails 7.1.3.2 (Hotwire/Turbo/Stimulus), TailwindCSS, DaisyUI　 |
| Backend | Rails 7.1.3.2 (Hotwire/Turbo/Stimulus) |
| Database | PostgreSQL |
| Environment | Docker / docker-compose |
| Infrastructure | Render.com |
| other | [Line Messaging API](https://github.com/line/line-bot-sdk-ruby), [Rakuten_web_service API](https://github.com/rakuten-ws/rws-ruby-sdk/blob/master/README.ja.md) |

## 画面遷移図
Figma : https://www.figma.com/design/x2fw3OmqTtjzpc56sfMBTQ/Pantry-Chef-Notifier?m=auto&t=HUXtHfzUDPXl2FWk-6

## ER図
![Pantry-Chef-Notifier-ER図](https://github.com/user-attachments/assets/193c837a-62e0-4637-8bb6-b927b632b2f1)
