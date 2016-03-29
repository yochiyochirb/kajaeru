もし(/^マイページへアクセスする$/) do
  within '.current-user__mypage-link' do
    find('a').click
  end
end

もし(/^投票内容を確認する$/) do
  click_on '投票した内容を確認する'
end


前提(/^以下の内容で投票が済んでいる:$/) do |table|
  table.hashes.each do |row|
    candidate = row.fetch('投票対象者')
    comment = row.fetch('コメント')

    steps <<-EOS
      もし Kajaeru にアクセスする
      かつ 投票ページを表示する
      かつ 以下の内容で新規投票する:
        | 投票対象     | コメント   |
        | #{candidate} | #{comment} |
      ならば 投票が完了すること
    EOS
  end
end

ならば(/^以下の投票内容が表示されていること:$/) do |table|
  table.hashes.each do |row|
    candidate = row.fetch('投票対象者')
    comment = row.fetch('コメント')

    within '.my-vote' do
      expect(page).to have_content(candidate)
      expect(page).to have_content(comment)
    end
  end
end
