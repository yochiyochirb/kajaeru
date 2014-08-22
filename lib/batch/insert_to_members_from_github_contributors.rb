# -*- coding: utf-8 -*-

require 'open-uri'

res = open('https://api.github.com/repos/yochiyochirb/meetups/stats/contributors')

status, msg = res.status 

if status == '200'
  contributors = ActiveSupport::JSON.decode res.read
  contributors.each { |contributor|
    author = contributor['author']
    unless Member.find_by_uid(author['id'])
      member = Member.create!(nickname: author['login'], provider: 'github', uid: author['id'], image: author['avatar_url'])
    else
      puts "#{author['login']} exists already."
    end
  } 
else
  puts "STATUS CODE: #{status}, MESSAGE: #{msg}"
end
