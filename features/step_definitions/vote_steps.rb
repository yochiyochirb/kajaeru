もし(/^投票ページを表示する$/) do
  within '.vote-link' do
    all('a').first.click
  end
end

もし(/^以下の内容で新規投票する:$/) do |table|
  table.hashes.each do |row|
    target = row.fetch('投票対象')
    comment = row.fetch('コメント', 'sample comment')
   
    choose target
    fill_in '推薦コメント(任意)', with: comment
    click_button '投票する'
  end
end

ならば(/^投票が完了すること$/) do
  within '.page-title' do
    expect(page).to have_content '投票完了画面'
  end
end
