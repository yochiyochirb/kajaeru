もし(/^イベント一覧ページを表示する$/) do
  click_on 'イベント一覧'
end

ならば(/^以下のイベントの一覧が表示されていること:$/) do |table|
  table.hashes.each do |row|
    event_name = row.fetch('イベント名')

    within '.event-list' do
      expect(page).to have_content(event_name)
    end
  end
end

もし(/^"([^"]*)" イベントのリンクをクリックする$/) do |event_name|
  click_on event_name
end

ならば(/^"([^"]*)" のイベントページが表示されること$/) do |event_name|
  within '.page-title' do
    expect(page).to have_content(event_name)
  end
end

もし(/^"([^"]*)" イベントのページを表示する$/) do |event_name|
  steps <<-EOS
    もし Kajaeru にアクセスする
    かつ イベント一覧ページを表示する
    かつ "#{event_name}" イベントのリンクをクリックする
  EOS
end

ならば(/^イベントへの投票権限がないことを示す表示がされていること$/) do
  within '.event-menu' do
    expect(page).to have_content('このイベントには投票できません')
  end
end

ならば(/^イベントが投票期間中でないことを示す表示がされていること$/) do
  within '.event-menu' do
    expect(page).to have_content('このイベントの投票期間ではありません')
  end
end

前提(/^以下のイベントが登録されている:$/) do |table|
  # XXX 今は画面からイベントを作成できない
  table.hashes.each do |row|
    event_name = row.fetch('イベント名')
    state = row.fetch('集計の公開状態', '公開') == '公開' ? true : false
    voting_starts_at = row.fetch('開始日時', Time.zone.parse('1000-01-01'))
    voting_ends_at = row.fetch('終了日時', Time.zone.parse('3000-01-01'))

    Event.create!(name: event_name, total_opened: state,
                  voting_starts_at: voting_starts_at, voting_ends_at: voting_ends_at)
  end
end
