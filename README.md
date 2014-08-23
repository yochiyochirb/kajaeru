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

```sh
git clone https://github.com/yochiyochirb/kajaeru.git
cd kajaeru

bundle install --path vendor/bundle

cp config/database.yml.sample config/database.yml

bundle exec rake db:create
bundle exec rake db:migrate

bundle exec rails runner lib/batch/insert_to_members_from_github_contributors.rb

# ex) bash,zsh
export GITHUB_CLIENT_ID="XXXXXXXXX"         # Kajaeru用のClient IDを設定
export GITHUB_CLIENT_SECRET="XXXXXXXXXXXXX" # Kajaeru用のClient Secretを設定

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
