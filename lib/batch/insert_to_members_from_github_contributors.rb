require 'open-uri'

unless ARGV[0]
  puts <<-EOS
イベントが指定されていません。引数でイベントを指定してください。
例) bin/rails runner lib/batch/insert_to_members_from_github_contributors.rb "Ruby Kaja 2016"
  EOS
  exit 1
end

res = open('https://api.github.com/repos/yochiyochirb/meetups/stats/contributors')

# res.status => ["200", "OK"]
status, msg = res.status

unless status == '200'
  puts "STATUS CODE: #{status}, MESSAGE: #{msg}"
  exit
end

# コマンドライン引数で指定したイベント名でイベントを作る
unless event = Event.find_by(name: ARGV[0])
  event = Event.create!(name: ARGV[0])
end

contributors = ActiveSupport::JSON.decode res.read
contributors.each do |contributor|
  author = contributor['author']
  next if Member.find_by(uid: author['id'].to_s)
  Member.create!(
    nickname: author['login'],
    provider: 'github',
    uid: author['id'].to_s,
    image: author['avatar_url'])
end

Member.all.map do |member|
  [Candidate, Voter].each do |klass|
    next if klass.find_by(member_id: member.id)
    klass.create!(member_id: member.id, event: event)
  end
end
