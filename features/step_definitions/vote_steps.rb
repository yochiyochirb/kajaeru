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

# XXX 自分以外の投票編集画面には現実的に行けてはいけない（アプリでもそういう仕様になっている）のに、
#     current_user にアクセスできないという実装都合で placeholder にしてしまうと
#     「自分以外の画面にも行けるというオプションがあるのか」と思われてしまいそう
ならば(/^"([^"]*)" の投票編集画面に遷移すること$/) do |nickname|
  member = Member.find_by(nickname: nickname)
  my_vote = member.voter.vote

  expect(page).to have_current_path(edit_vote_path(my_vote))
end

もし(/^以下の内容で投票がある:$/) do |table|
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
