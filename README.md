# Kajaeru

## 環境構築

```sh
git clone https://github.com/yochiyochirb/kajaeru.git
cd kajaeru

bundle install --path vendor/bundle

cp config/database.yml.sample config/database.yml

bundle exec rake db:create
bundle exec rake db:migrate

bundle exec rails server
```

## 作業に入るまえに
[Wiki](https://github.com/yochiyochirb/kajaeru/wiki) に開発ルールやスケジュールがまとめてありますので、ご一読ください。
