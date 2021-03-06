もし(/^マイページで投票内容を確認する$/) do
  find('.current-user__mypage-link').click

  click_on '投票した内容を確認する'
end

前提(/^以下の内容で投票が済んでいる:$/) do |table|
  table.hashes.each do |row|
    event_name = row.fetch('イベント')
    candidate = row.fetch('投票対象者')
    comment = row.fetch('コメント')

    steps <<-EOS
      もし Kajaeru にアクセスする
      かつ 以下の内容で新規投票する:
        | イベント      | 投票対象     | コメント   |
        | #{event_name} | #{candidate} | #{comment} |
    EOS
  end
end

ならば(/^以下の投票内容が表示されていること:$/) do |table|
  table.hashes.each do |row|
    candidate = row.fetch('投票対象者')
    comment = row.fetch('コメント')

    within '.my-vote-list' do
      expect(page).to have_content(candidate)
      expect(page).to have_content(comment)
    end
  end
end
