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
