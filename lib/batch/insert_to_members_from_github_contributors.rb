require 'open-uri'

res = open('https://api.github.com/repos/yochiyochirb/meetups/stats/contributors')

# res.status => ["200", "OK"]
status, msg = res.status 

if status == '200'
  contributors = ActiveSupport::JSON.decode res.read
  contributors.each do |contributor|
    author = contributor['author']
    unless Member.find_by_uid(author['id'])
      member = Member.create!(nickname: author['login'], provider: 'github', uid: author['id'], image: author['avatar_url'])
    else
      puts "#{author['login']} exists already."
    end
  end
else
  puts "STATUS CODE: #{status}, MESSAGE: #{msg}"
end
