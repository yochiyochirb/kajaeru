前提(/^GitHub アカウント "([^"]*)" でサインインしている$/) do |account|
  member = Member.find_by!(nickname: account)

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
    provider: member.provider,
    uid: member.uid,
    info: {
      nickname: member.nickname
    }
  )

  Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

  steps <<-EOS
    もし Kajaeru にアクセスする
    ならば サインインページが表示されていること

    もし サインインする
    ならば ホームに遷移すること
  EOS
end

もし(/^サインインする$/) do
  click_on 'Github でサインイン'
end

ならば(/^サインインページが表示されていること$/) do
  expect(current_path).to eq signin_path
end

前提(/^以下の投票権限のメンバーがサインインしている:$/) do |table|
  table.hashes.each do |row|
    member = Member.find_by(nickname: row.fetch('ニックネーム'))
    event = Event.find_by(name: row.fetch('イベント'))
    vote_permission = row.fetch('投票権限', 'あり')
    expect(vote_permission).to be_in(%w(あり なし))

    step %(GitHub アカウント "#{member.nickname}" でサインインしている)

    if vote_permission == 'あり'
      event.voters.create!(member: member) \
                         unless member.voters.find_by(event_id: event.id)
    else
      member.voters.each do |voter|
        next unless voter.event == event
        voter&.destroy
      end
    end
  end
end

もし(/^サインアウトする$/) do
  find('.current-user__signout-link').click
end
