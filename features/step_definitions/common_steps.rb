もし 'd' do
  binding.pry
end

ならば(/^"([^"]*)" というリンクが表示されていること$/) do |link|
  expect(page).to have_link link
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

もし(/^"([^"]*)" の投票詳細ページに直接アクセスする$/) do |nickname|
  vote_of_others = Member.find_by(nickname: nickname).voter.vote
  visit vote_path(vote_of_others.id)
end

もし(/^"([^"]*)" の投票編集ページに直接アクセスする$/) do |nickname|
  vote_of_others = Member.find_by(nickname: nickname).voter.vote
  visit edit_vote_path(vote_of_others.id)
end

ならば(/^該当ページが見つからないこと$/) do
  # TODO 404 ページに出る文言を have_content しているかで確認する
  #expect(page).to have_content('foobar')
  pending
end
