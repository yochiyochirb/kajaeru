もし 'd' do
  binding.pry
end

ならば(/^"([^"]*)" というリンクが表示されていること$/) do |link|
  expect(page).to have_link link
end

ならば(/^"([^"]*)" というリンクが表示されていないこと$/) do |link|
  expect(page).not_to have_link link
end

もし(/^Kajaeru にアクセスする$/) do
  visit '/'
end

ならば(/^ホームに遷移すること$/) do
  expect(page).to have_content 'よちよち.rb の Ruby Kaja を選ぼう！'
end

もし(/^ホームにアクセスする$/) do
  click_link 'ホーム'
end

ならば(/^投票対象者一覧が表示されていること$/) do
  Member.all.map(&:nickname).each do |nickname|
    expect(page).to have_content nickname
  end
end

ならば(/^"([^"]*)" というメッセージが表示されていること$/) do |message|
  within '.alert .message' do
    expect(page).to have_content(message)
  end
end

ならば(/^まだ投票していないのがわかること$/) do
  expect(page).to have_content('まだ投票していません')
end

ならば(/^サインインページに遷移すること$/) do
  expect(page).to have_current_path(signin_path)
end

もし(/^"([^"]*)" イベントの "([^"]*)" の投票詳細ページに直接アクセスする$/) do |event_name, nickname|
  event = Event.find_by(name: event_name)
  member = Member.find_by(nickname: nickname)
  vote = Vote.by_member(member).for_this_event(event).first
  visit event_vote_path(event, vote)
end

もし(/^"([^"]*)" イベントの "([^"]*)" の投票編集ページに直接アクセスする$/) do |event_name, nickname|
  event = Event.find_by(name: event_name)
  member = Member.find_by(nickname: nickname)
  vote = Vote.by_member(member).for_this_event(event).first
  visit edit_event_vote_path(event, vote)
end

ならば(/^該当ページが見つからないこと$/) do
  expect(page.status_code).to eq(404)
end
