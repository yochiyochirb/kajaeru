もし(/^"([^"]*)" イベントの投票ページを表示する$/) do |event_name|
  steps <<-EOS
    もし イベント一覧ページを表示する
    かつ "#{event_name}" イベントのリンクをクリックする
  EOS

  click_on '投票する'
end

もし(/^以下の内容で新規投票(?:する|している):$/) do |table|
  table.hashes.each do |row|
    event_name = row.fetch('イベント')
    target = row.fetch('投票対象')
    comment = row.fetch('コメント', 'sample comment')

    step %("#{event_name}" イベントの投票ページを表示する)

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

もし(/^"([^"]*)" イベントの新規投票画面に直接アクセスする$/) do |event_name|
  event = Event.find_by(name: event_name)
  visit new_event_vote_path(event)
end

ならば(/^"([^"]*)" のイベントページに遷移すること$/) do |event_name|
  event = Event.find_by(name: event_name)
  expect(page).to have_current_path(event_path(event))
end

もし(/^以下の内容で投票がある:$/) do |table|
  Vote.all.each(&:destroy)

  table.hashes.each do |row|
    event_name = row.fetch('イベント')
    voter = row.fetch('投票者')
    candidate = row.fetch('投票対象者')
    comment = row.fetch('コメント')

    using_session SecureRandom.uuid do
      steps <<-EOS
        前提 GitHub アカウント "#{voter}" でログインしている
        もし 以下の内容で新規投票する:
        | イベント      | 投票対象     | コメント   |
        | #{event_name} | #{candidate} | #{comment} |
        かつ サインアウトする
      EOS
    end
  end
end

もし(/^"([^"]*)" イベントの集計ページを表示する$/) do |event_name|
  steps <<-EOS
    もし イベント一覧ページを表示する
    かつ "#{event_name}" イベントのリンクをクリックする
  EOS

  click_on '集計を見る'
end

ならば(/^以下のように各投票対象者の得票数とコメントが表示されている:$/) do |table|
  table.hashes.each.with_index(1) do |row, index|
    target = row.fetch('投票対象')
    total = row.fetch('得票数')
    comments = row.fetch('コメント').split(',').map(&:strip)

    within(:xpath, %{(//div[@class="vote-result"])[#{index}]}) do
      expect(page).to have_content("#{target} #{total} 票")
      comments.each do |comment|
        expect(page).to have_content(comment)
      end
    end
  end
end
