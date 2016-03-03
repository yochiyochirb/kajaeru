# Kajaeru [![wercker status](https://app.wercker.com/status/33e8196b8245e9c71d03deb1f89997f5/s/master "wercker status")](https://app.wercker.com/project/bykey/33e8196b8245e9c71d03deb1f89997f5) [![Code Climate](https://codeclimate.com/github/yochiyochirb/kajaeru/badges/gpa.svg)](https://codeclimate.com/github/yochiyochirb/kajaeru)

## What is Kajaeru?
Kajaeru is a web-based voting application to elect Ruby Kaja. ( "eru(選る)" is Japanese to select someone or something from among several. )

About Ruby Kaja, see the [web page](http://kaja.rubyist.net/) for more information.

## Usage

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

## Contribution
Only Yochiyochi.rb members can join and send PRs to this project.

If you are a Yochiyochi.rb member and want to improve Kajaeru with us, please read [wiki(Japanese)](https://github.com/yochiyochirb/kajaeru/wiki) at first.
