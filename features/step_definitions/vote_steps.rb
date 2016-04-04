もし(/^投票ページを表示する$/) do
  click_on '投票する'
end

もし(/^以下の内容で新規投票(?:する|している):$/) do |table|
  table.hashes.each do |row|
    target = row.fetch('投票対象')
    comment = row.fetch('コメント', 'sample comment')

    click_on '投票する'

    choose target
    fill_in '推薦コメント(任意)', with: comment
    click_button '投票する'
  end
end

ならば(/^投票が完了すること$/) do
  within '.page-title' do
    expect(page).to have_content('投票完了画面')
  end
end

ならば(/^投票対象者に "([^"]*)" がいないこと$/) do |account|
  within '.candidates' do
    expect(page).not_to have_content(account)
  end
end

もし(/^新規投票画面に直接アクセスする$/) do
  visit new_vote_path
end

# XXX 自分以外の投票編集画面には現実的に行けてはいけない（アプリでもそういう仕様になっている）のに、
#     current_user にアクセスできないという実装都合で placeholder にしてしまうと
#     「自分以外の画面にも行けるというオプションがあるのか」と思われてしまいそう
ならば(/^"([^"]*)" の投票編集画面に遷移すること$/) do |nickname|
  member = Member.find_by(nickname: nickname)
  my_vote = member.voter.vote

  expect(page).to have_current_path(edit_vote_path(my_vote))
end
