require 'open-uri'

res = open('https://api.github.com/repos/yochiyochirb/meetups/stats/contributors')

# res.status => ["200", "OK"]
status, msg = res.status 

unless status == '200'
  puts "STATUS CODE: #{status}, MESSAGE: #{msg}"
  exit
end

contributors = ActiveSupport::JSON.decode res.read
contributors.each do |contributor|
  author = contributor['author']
  if Member.find_by(uid: author['id'])
    puts "#{author['login']} exists already."
    next
  end
  member = Member.create!(nickname: author['login'], provider: 'github', uid: author['id'], image: author['avatar_url'])
end
