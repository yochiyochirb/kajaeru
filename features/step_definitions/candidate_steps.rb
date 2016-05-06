前提(/^以下の候補者がいる:$/) do |table|
  table.hashes.each do |row|
    member = Member.find_by(nickname: row.fetch('ニックネーム'))
    event = Event.find_by(name: row.fetch('イベント'))
    event.candidates.create!(member: member)
  end
end

もし(/^"([^"]*)" イベントの候補者一覧ページを表示する$/) do |event_name|
  steps <<-EOS
    もし イベント一覧ページを表示する
    かつ "#{event_name}" イベントのリンクをクリックする
  EOS

  click_on '候補者の一覧を見る'
end

ならば(/^"([^"]*)" イベントの候補者の一覧が表示される/) do |event_name|
  event = Event.find_by(name: event_name)

  event.candidates.each do |candidate|
    within('.candidate-list') do
      expect(page).to have_content(candidate.member.nickname)
    end
  end
end
