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
