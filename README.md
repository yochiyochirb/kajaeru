# Kajaeru

## 事前準備

Kajaeruのログイン機能はGithub APIのOauthを利用するため、[こちら](https://github.com/settings/applications)より、Developer applicationsに登録し、Kajaeruのための __Client ID__ と __Client Secret__ を取得してください。

### 設定内容サンプル

`localhost:3000`を環境に応じて変更してください。

* Application name（任意）
  * kajaeru
* Homepage URL
  * http://localhost:3000
* Description
  * ruby kaja投票アプリ
* Authorization callback URL
  * http://localhost:3000/auth/github/callback

## 環境構築
1.ローカルのターミナルで以下の操作を実行してください。

```sh
git clone https://github.com/yochiyochirb/kajaeru.git
cd kajaeru

bundle install --path vendor/bundle

cp config/database.yml.sample config/database.yml
# condig/database.yml を自分の環境にあわせて適宜修正する（基本的には何もしなくても動くはず）
cp config/application.yml.sample config/application.yml

bundle exec rake db:create
bundle exec rake db:migrate

bundle exec rails runner lib/batch/insert_to_members_from_github_contributors.rb
```

2.「事前準備」で取得した __Client ID__ と __Client Secret__ を`config/application.yml`に記載してください。`your_xxx` となっているところを、取得した値に置き換えるようになります。

```yml
# examples
GITHUB_CLIENT_ID: 'ekjfksdifjikji3wsfalsd'               # Kajaeru用のClient IDを設定
GITHUB_CLIENT_SECRET: '23jijvc9ui3jikjkk22k49vfjdk58uv'  # Kajaeru用のClient Secretを設定
```

3.サーバを起動します。

```sh
bundle exec rails server
```

### herokuへのデプロイ

herokuへデプロイするためには、以下コマンドにより環境変数を設定する必要があります。

```sh
heroku config:set GITHUB_CLIENT_ID="XXXXXXXXX"         # Kajaeru用のClient IDを設定
heroku config:set GITHUB_CLIENT_SECRET="XXXXXXXXXXXXX" # Kajaeru用のClient Secretを設定
```

## 作業に入るまえに
[Wiki](https://github.com/yochiyochirb/kajaeru/wiki) に開発ルールやスケジュールがまとめてありますので、ご一読ください。
