もし(/イベント一覧ページを表示する$/) do
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

# TODO まだ使ってない
もし(/^"([^"]*)" のイベントページを表示する$/) do |event_name|
  click_on '投票する'
end
