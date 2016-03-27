# Kajaeru [![Build Status](https://travis-ci.org/yochiyochirb/kajaeru.svg?branch=master)](https://travis-ci.org/yochiyochirb/kajaeru) [![Code Climate](https://codeclimate.com/github/yochiyochirb/kajaeru/badges/gpa.svg)](https://codeclimate.com/github/yochiyochirb/kajaeru)

## What is Kajaeru?
Kajaeru is a web-based voting application to elect Ruby Kaja. ( "eru(選る)" is Japanese to select someone or something from among several. )

About Ruby Kaja, see the [web page](http://kaja.rubyist.net/) for more information.

## Usage

Kajaeru runs on heroku.

```
# clone this repository
git clone git@github.com:yochiyochirb/kajaeru.git
cd kajaeru

# create heroku app for kajaeru
heroku create
git push heroku master

# run migration
heroku run rake db:migrate

# set environment variable
heroku config:set GITHUB_CLIENT_ID=XXXXX
heroku config:set GITHUB_CLIENT_SECRET=XXXXX

# open browser
heroku open
```

Before using Kajaeru you need to register Kajaeru, that is an OAuth application, in [GitHub Account Settings Menu](https://github.com/settings/developers).

At the "Register a new OAuth application" window, type the texts below:

- Application name
  - Kajaeru (or other name you can recognize)
- Homepage URL
  - URL of your application
- Description
  - A voting application for Ruby Kaja
- Authorization callback URL
  - #{your_applicaton_url}/auth/github/callback

## Development

### Setup

```
# clone this repository
git clone git@github.com:yochiyochirb/kajaeru.git
cd kajaeru

# install gem
bundle install --without production

# migration
cp config/database.yml.sample config/database.yml
bin/rails db:create db:migrate db:seed

# start
bin/rails server
```

Open your browser and access http://localhost:3000 .

### Test

```sh
# unit test
bin/rake test

# cucumber
bin/rails cucumber
```

## Contribution
Only Yochiyochi.rb members can join and send PRs to this project.

If you are a Yochiyochi.rb member and want to improve Kajaeru with us, please read [wiki(Japanese)](https://github.com/yochiyochirb/kajaeru/wiki) at first.
